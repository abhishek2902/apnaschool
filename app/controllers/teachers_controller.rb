class TeachersController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_teacher

  def index
    @teacher=current_user
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def authorize_teacher
    unless current_user&.teacher?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

end
