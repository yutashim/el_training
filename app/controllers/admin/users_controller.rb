class Admin::UsersController < ApplicationController
  # before_action :admin_user?
  def index
    # @users = User.all
    @users = User.includes(:tasks)
  end
end
