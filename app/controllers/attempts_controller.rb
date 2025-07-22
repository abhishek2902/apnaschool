
class AttemptsController < ApplicationController
    def index
        @attempts = current_user.attempts.includes(:test)
    end

    def show
      @attempt = Attempt.find(params[:id])
      @test = @attempt.test
    end
  
    def create
      @test = Test.find(params[:test_id])
      @attempt = current_user.attempts.create!(test: @test)
  
      params[:responses].each do |question_id, selected_option|
        @attempt.responses.create!(question_id: question_id, selected_option: selected_option)
      end
  
      score = @attempt.responses.joins(:question).where("questions.correct_option = responses.selected_option").count
      @attempt.update!(score: score)
  
      redirect_to @attempt, notice: "Test submitted! Your score: #{score}/#{@test.questions.count}"
    end
  end
