class Admin::UsersController < ApplicationController
  before_action :admin_user?
  before_action :set_user, only: [:edit, :destroy ]
  def index
    # @users = User.all
    @users = User.includes(:tasks)
  end

  def edit
    @user.update(admin: true)
    redirect_to admin_users_path
  end

  def destroy
    @user.update(admin: false)
    redirect_to admin_users_path
  end

  private
  def admin_user?
    redirect_to new_session_path unless logged_in?
    if @current_user.admin != true
      flash[:notice] = 'アクセス権限がありません'
      redirect_to user_path(@current_user.id)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
