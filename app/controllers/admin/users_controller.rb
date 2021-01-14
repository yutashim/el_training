class Admin::UsersController < ApplicationController
  # before_action :admin_user?
  def index
    @users = User.all
  end
end
