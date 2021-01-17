class SessionsController < ApplicationController
  def new
  end

  def create
    pr = params[:session]
    user = User.find_by(email: pr[:email])
    if user && user.authenticate(pr[:password])
      session[:user_id] = user.id
      flash[:notice] = "#{user.name}さん、お帰りなさい"
      redirect_to user_path(user.id)
    else
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
  end

end
