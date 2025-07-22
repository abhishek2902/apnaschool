class GrievancesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :like, :new, :create]
  before_action :authorize_teacher_or_admin, only: [ :resolve]
  before_action :authorize_admin, only: [:destroy]

  def index
    @grievances=Grievance.all
    @grievances = Grievance.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @grievance = Grievance.new
  end

  def create
    @grievance = Grievance.new(grievance_params)
  
    if @grievance.save
      redirect_to grievances_path, notice: "Complaint submitted successfully."
    else
      render :new
    end
  end

  def resolve
    @grievance = Grievance.find(params[:id])
    @grievance.update(flag: !@grievance.flag)
      
    redirect_to grievances_path, notice: "Complaint marked as #{@grievance.flag? ? 'Resolved' : 'Pending'}."  
  end

  def like
    @grievance = Grievance.find(params[:id])
    @grievance.update(likes: @grievance.likes + 1)  
    redirect_to grievances_path
  end

  def destroy
    @grievance=Grievance.find(params[:id])
    @grievance.destroy
    redirect_to grievances_path
  end

  private
  
  def grievance_params
    params.require(:grievance).permit(:name, :text)
  end

  def authorize_teacher_or_admin
    unless current_user&.teacher? || current_user&.admin?
      redirect_to grievances_path, alert: "You are not authorized to perform this action."
    end
  end

  def authorize_admin
    unless current_user&.admin?
      redirect_to grievances_path, alert: "Only admins can perform this action."
    end
  end
end
