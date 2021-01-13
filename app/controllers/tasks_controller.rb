class TasksController < ApplicationController
  PER = 6
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @order = "ASC"
    @tasks = Task.order(created_at: 'DESC').page(params[:page]).per(PER)
    if params[:sort_expired]
      if params[:sort_expired] == "ASC"
        @tasks = Task.order(deadline: 'ASC').page(params[:page]).per(PER)
        @order = "DESC"
      else
        @tasks = Task.order(deadline: 'DESC').page(params[:page]).per(PER)
        @order = "ASC"
      end
    elsif params[:sort_priority]
      @tasks = Task.order(priority: 'ASC').page(params[:page]).per(PER)
    elsif params[:search]
      @tasks = Task.search_tasks(params[:search]).page(params[:page]).per(PER)
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = 'タスクを作成しました'
      redirect_to task_path(@task.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = 'タスクを削除しました'
    redirect_to tasks_path
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :detail, :deadline, :status, :priority)
  end

end
