class ApplicationController < ActionController::Base
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
