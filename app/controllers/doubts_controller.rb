class DoubtsController < ApplicationController
  before_action :authenticate_user!

  def index
    @doubts = current_user.doubts.order(created_at: :desc)
  end

  def new
    @doubt = Doubt.new
  end

  def create
    @doubt = current_user.doubts.build(doubt_params)
  
    if @doubt.save
      answer = CohereService.get_answer(@doubt.question)
      @doubt.update(answer: answer)
      redirect_to @doubt, notice: "Doubt submitted and answered!"
    else
      render :new
    end
  end

  def destroy
    @doubt = Doubt.find(params[:id])
    @doubt.destroy
    redirect_to doubts_path
  end

  def show
    @doubt = Doubt.find(params[:id])
  end

  private

  def doubt_params
    params.require(:doubt).permit(:question)
  end

end
