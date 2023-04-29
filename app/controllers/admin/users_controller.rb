class Admin::UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]
    before_action :admin_required
  
  
  def index
    @users = User.order(created_at: :asc)
    @users = @users.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザーを登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザーを変更しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_url, notice: "ユーザーを削除しました。"
    else
      redirect_to users_url, notice: "このユーザーは削除できません。"
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :admin)
  end
end
