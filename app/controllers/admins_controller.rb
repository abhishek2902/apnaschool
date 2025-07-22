class AdminsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin

    def index
        @student=Student.new
        @students=Student.all.order(roll: :asc)
        @teacher=Teacher.new
        @teachers=Teacher.all.order(roll: :asc)
        @admin=Admin.new
        @admins=Admin.all.order(roll: :asc)
    end

# Student actions
    def create_student

      dateofbirth = student_params[:dateofbirth]  # This is likely a string like "2025-04-10"
      formatteddob = Date.parse(dateofbirth).strftime('%d%m%Y') rescue nil

      @user = User.new(name: student_params[:name],email: student_params[:email], password: formatteddob,password_confirmation: formatteddob, role: 'student')
      @student=Student.new(student_params)

      if @user.save

        @student=Student.new(student_params)

        if @student.save
          redirect_to admins_path
        else
          @students=Student.all.order(roll: :asc)
          @teacher=Teacher.new
          @teachers=Teacher.all.order(roll: :asc)
          @admin=Admin.new
          @admins=Admin.all.order(roll: :asc)
          render 'index'
          @user.destroy
        end

      else
        @students=Student.all.order(roll: :asc)
        @teacher=Teacher.new
        @teachers=Teacher.all.order(roll: :asc)
        @admin=Admin.new
        @admins=Admin.all.order(roll: :asc)
        flash[:alert] = "Failed to create user!"
        render :index
      end


    end

    def edit_student
        @student=Student.find(params[ :id])
    end

    def update_student
        @student=Student.find(params[ :id])
        @student.update(student_params)

        if @student.save
          redirect_to admins_path
        else
          render 'edit_student'
        end
    end

    def delete_student
        @student=Student.find(params[ :id])
        @user=User.find_by(email: @student.email)
        @student.destroy
        @user && @user.destroy
        redirect_to admins_path
    end

    def show_student
        @student=Student.find(params[ :id])
    end


# Teacher actions
    def create_teacher
      dateofbirth = teacher_params[:dateofbirth]
      formatteddob = Date.parse(dateofbirth).strftime('%d%m%Y') rescue nil

      @user = User.new(name: teacher_params[:name],email: teacher_params[:email], password: formatteddob,password_confirmation: formatteddob, role: 'teacher')
      @teacher=Teacher.new(teacher_params)

      if @user.save
        @teacher=Teacher.new(teacher_params)

        if @teacher.save
          redirect_to admins_path
        else
          @student=Student.new
          @students=Student.all.order(roll: :asc)
          @teachers=Teacher.all.order(roll: :asc)
          @admin=Admin.new
          @admins=Admin.all.order(roll: :asc)
          @user.destroy
          render 'index'
        end
      
      else
        @student=Student.new
        @students=Student.all.order(roll: :asc)
        @teachers=Teacher.all.order(roll: :asc)
        @admin=Admin.new
        @admins=Admin.all.order(roll: :asc)
        flash[:alert] = "Failed to create user!"
        render :index
      end

    end

    def edit_teacher
        @teacher=Teacher.find(params[ :id])
    end

    def update_teacher
        @teacher=Teacher.find(params[ :id])
        @teacher.update(teacher_params)

        if @teacher.save
          redirect_to admins_path
        else
          render 'edit_teacher'
        end
    end

    def delete_teacher
        @teacher=Teacher.find(params[ :id])
        @user=User.find_by(email:@teacher.email)
        @teacher.destroy
        @user && @user.destry
        redirect_to admins_path
    end

    def show_teacher
        @teacher=Teacher.find(params[ :id])
    end

# Admin actions
    def create
      dateofbirth = admin_params[:dateofbirth]  # This is likely a string like "2025-04-10"
      formatteddob = Date.parse(dateofbirth).strftime('%d%m%Y') rescue nil
      @user = User.new(name: admin_params[:name],email: admin_params[:email], password: formatteddob,password_confirmation: formatteddob, role: 'admin')
      @admin=Admin.new(admin_params)

      if @user.save
        if @admin.save
          redirect_to admins_path
        else
          @student=Student.new
          @students=Student.all.order(roll: :asc)
          @teacher=Teacher.new
          @teachers=Teacher.all.order(roll: :asc)
          @admins=Admin.all.order(roll: :asc)
          render 'index'
          @user.destroy
        end

      else
        @student=Student.new
        @students=Student.all.order(roll: :asc)
        @teacher=Admin.new
        @teachers=Teacher.all.order(roll: :asc)
        @admins=Admin.all.order(roll: :asc)
        flash[:alert] = "Failed to create user!"
        render :index
      end

    end

    def edit
        @admin=Admin.find(params[ :id])
    end

    def update
        @admin=Admin.find(params[ :id])
        @admin.update(admin_params)

        if @admin.save
          redirect_to admins_path
        else
          render 'edit'
        end
    end

    def destroy
        @admin=Admin.find(params[ :id])
        @user=User.find_by(email:@admin.email)
        @user.destroy
        @admin.destroy
        redirect_to admins_path
    end

    def show
        @admin=Admin.find(params[ :id])
    end

    def profile
      @admin=current_user
    end








    private

    def admin_params
      params.require(:admin).permit(:name, :email, :subject, :roll, :age, :dateofbirth, :sex, :fathername, :mothername, :address, :mobile)
    end

    def teacher_params
        params.require(:teacher).permit(:name, :email, :subject, :roll, :age, :dateofbirth, :sex, :fathername, :mothername, :address, :mobile)
    end

    def student_params
        params.require(:student).permit(:name, :email, :classname, :roll, :age, :dateofbirth, :sex, :fathername, :mothername, :address)
    end

    def authorize_teacher_or_admin
        unless current_user&.teacher? || current_user&.admin?
          redirect_to root_path, alert: "You are not authorized to perform this action."
        end
    end
    
    def authorize_admin
        unless current_user&.admin?
            redirect_to root_path, alert: "Only admins can perform this action."
        end
    end
end