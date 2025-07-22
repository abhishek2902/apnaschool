class QuestionsController < ApplicationController
  def new
    @test = Test.find(params[:test_id])
    @question = @test.questions.build
  end

  def create
    @test = Test.find(params[:test_id])
    @question = @test.questions.build(question_params)
    
    if @question.save
      redirect_to new_test_question_path(@test), notice: "Question added! Add more or finish the test."
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:content, :option_a, :option_b, :option_c, :option_d, :correct_option)
  end
  
end
