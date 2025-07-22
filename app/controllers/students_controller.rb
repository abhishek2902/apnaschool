class StudentsController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_student

  def index
    @student =current_user
  end

  def show
  end

  def new
    # @student=Student.new
  end

  def create
    @student=Student.new(student_params)

    if @student.save
      redirect_to admins_path
    # else
    #   render 'admins/index'
    end
  end

  def edit
  end

  private
  def student_params
    params.require(:student).permit(:name, :email, :classname, :roll, :age, :dateofbirth, :sex, :fathername, :mothername, :address)
  end

  def authorize_student
    if current_user&.teacher? || current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

end
