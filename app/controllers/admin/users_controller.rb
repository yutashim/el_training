class Admin::UsersController < ApplicationController
  before_action :admin_user?
  def index
    # @users = User.all
    @users = User.includes(:tasks)
  end

  private
  def admin_user?
    redirect_to new_session_path unless logged_in?
    if @current_user.admin != true
      flash[:notice] = 'アクセス権限がありません'
      redirect_to user_path(@current_user.id)
    end
  end
end
