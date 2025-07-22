class NoticesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :like]
  before_action :authorize_teacher_or_admin, only: [:new, :create, :edit, :update]
  before_action :authorize_admin, only: [:destroy]

  def index
    @notices = Notice.all.order(created_at: :desc)
  end

  def new
    @notice= Notice.new
  end

  def create
    @notice=Notice.new(notice_params)

    if @notice.save
      redirect_to notices_path
    else
      render :new
    end
  end

  def destroy
    @notice =Notice.find(params[:id])
    @notice.destroy
    redirect_to notices_path
  end

  def edit
    @notice=Notice.find(params[:id])
  end

  def update
    @notice=Notice.find(params[:id])
    @notice.update(notice_params)
    redirect_to notices_path
  end

  def show
    @notice=Notice.find(params[:id])
  end

  def like
    @notice=Notice.find(params[:id])
    @notice.update(likes: @notice.likes+1)
    until params[ :id]
      redirect_to notices_path
    end
    redirect_back fallback_location: notices_path
  end

  private

  def notice_params
    params.require(:notice).permit(:title, :text)
  end

  def authorize_teacher_or_admin
    unless current_user&.teacher? || current_user&.admin?
      redirect_to notices_path, alert: "You are not authorized to perform this action."
    end
  end

  def authorize_admin
    unless current_user&.admin?
      redirect_to notices_path, alert: "Only admins can perform this action."
    end
  end
  
end