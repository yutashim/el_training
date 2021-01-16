class Admin::UsersController < ApplicationController
  before_action :admin_user?
  before_action :set_user, only: [:edit, :show ]
  def index
    # @users = User.all
    @users = User.includes(:tasks)
  end

  def edit
    @user.update(admin: true)
    redirect_to admin_users_path
  end

  def show
    @user.update(admin: false)
    if @user.errors.any?
      flash[:danger] = '管理者ユーザがいなくなってしまいます'
    end
    redirect_to admin_users_path
  end

  private
  def admin_user?
    unless logged_in?
        redirect_to new_session_path
    else
      if @current_user.admin != true
        flash[:danger] = 'アクセス権限がありません'
        redirect_to user_path(@current_user.id)
      end
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
