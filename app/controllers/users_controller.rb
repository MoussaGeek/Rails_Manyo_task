class UsersController < ApplicationController
    before_action :correct_user, only: [:show]
    skip_before_action :login_required, only: [:new, :create]
    before_action :same_user_or_admin_required, only: %i[ show edit update destroy ]
    
    def indexindex
        @users = User.order(created_at: :asc)
        redirect_to admin_users_path(@user) if current_user.admin == true
    end
    
    def show
        @tasks = @user.tasks.order(created_at: :desc)
    end

    def new
      @user = User.new
    end

    def edit
        redirect_to edit_admin_user_path(@user) if current_user.admin == true
    end

    def create
      @user = User.new(user_params)
      if @user.save
        log_in(@user)
        redirect_to user_path(@user.id)
      else
        render :new
      end
    end

    def update
        if @user.update(user_params)
          redirect_to @user, notice: "ユーザーを変更しました。"
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def show
      @user = User.find(params[:id])
    end
    private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to current_user unless current_user?(@user)
    end
end
