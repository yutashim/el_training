class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  def asc_desc_sort
    if params[:sort_expired] == "ASC"
      @tasks = Task.order(deadline: 'ASC')
      @order = "DESC"
    else
      @tasks = Task.order(deadline: 'DESC')
      @order = "ASC"
    end
  end
end


# sym = :priority
# Task.order(sym => 'ASC')
