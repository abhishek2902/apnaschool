class TestsController < ApplicationController

    def index
        @tests=Test.all
    end

    def new
      @test = Test.new
    end

    def create
      @test = current_user.tests.build(test_params)
      if @test.save
        redirect_to new_test_question_path(@test)
      else
        render :new
      end
    end

    def show
      @test = Test.find(params[:id])
      @questions = @test.questions
    end

    def destroy
        @test=Test.find(params[:id])
        if @test.destroy
            redirect_to tests_path
        else
         render :new
        end
    end

    def attempt
        @test = Test.find(params[:id])
        @questions = @test.questions
    end

    def submit_attempt
        @test = Test.find(params[:id])
        @attempt = Attempt.create(user: current_user, test: @test)
        
        score = 0
      
        params[:responses]&.each do |question_id, selected_option|
          question = Question.find(question_id)
          is_correct = selected_option == question.correct_option
      
          score += 1 if is_correct
      
          Response.create(
            attempt: @attempt,
            question: question,
            selected_option: selected_option
          )
        end
      
        @attempt.update(score: score)
      
        # redirect_to tests_path, notice: "Test submitted! Your score: #{score}/#{@test.questions.count}"
        redirect_to attempt_path(@attempt)
    end

    private

    def test_params
      params.require(:test).permit(:title)
    end
  end
