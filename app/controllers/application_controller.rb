class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  def asc_desc_sort(tasks)
    if params[:sort_expired] == "ASC"
      @tasks = tasks.order(deadline: 'ASC')
      @order = "DESC"
    else
      @tasks = tasks.order(deadline: 'DESC')
      @order = "ASC"
    end
  end
end


# sym = :priority
# Task.order(sym => 'ASC')
