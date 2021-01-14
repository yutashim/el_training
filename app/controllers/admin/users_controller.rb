class Admin::UsersController < ApplicationController
  before_action :admin_user?
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
    else
    end
  end

  def create
    @user.new(user_params)
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

private
def user_params
  params.require(:users).permit(:name, :email, :password, :password_digest)
end

def set_user
  @user = User.find(params[:id])
end

def admin_user?
end

end
