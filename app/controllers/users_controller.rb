class UsersController < ApplicationController
  before_action :users_logged_in?, except: [:new, :create,]
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :edit_user?, only: [:edit, :show]

  def new
    if logged_in? && @current_user.admin != true
      redirect_to user_path(@current_user.id)
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "#{@user.name}さん、はじめまして！"
      session[:user_id] = @user.id
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
    @tasks = @user.tasks
  end

  def destroy
    @user.destroy
    if @user.errors.any?
      flash[:danger] = '管理者ユーザがいなくなってしまいます'
    else
      flash[:notice] = 'ユーザを削除しました'
    end
    redirect_to admin_users_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def users_logged_in?
    redirect_to new_session_path unless logged_in?
  end

  def edit_user?
    if @current_user != @user && @current_user.admin != true
      # redirect_to user_path(@current_user.id)
      redirect_to tasks_path
    end
  end
end
