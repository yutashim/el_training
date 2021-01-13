class ApplicationController < ActionController::Base
  def asc_desc_sort(per)
    if params[:sort_expired] == "ASC"
      @tasks = Task.order(deadline: 'ASC').page(params[:page]).per(per)
      @order = "DESC"
    else
      @tasks = Task.order(deadline: 'DESC').page(params[:page]).per(per)
      @order = "ASC"
    end
  end
end
