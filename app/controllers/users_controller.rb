class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :current_user
  def new
    redirect_to tasks_path if @current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "#{@user.name}さん、はじめまして！"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "#{@user.name}さん、プロフィールを変更しました！"
      redirect_to user_path(@user.id)
    else
      render edit
    end
  end

  def show
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
