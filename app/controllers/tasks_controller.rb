class TasksController < ApplicationController
  PER = 6
  before_action :permit_tasks_page?
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :edit_task?, only: [:show, :edit, :update, :destroy]
  def index
    user_tasks = @current_user.tasks
    @order = "ASC"
    @tasks = user_tasks.order(created_at: 'DESC')
    if params[:sort_expired]
      asc_desc_sort(user_tasks)
    elsif params[:sort_priority]
      @tasks = user_tasks.order(priority: 'ASC')
    elsif params[:search]
      @tasks = user_tasks.search_tasks(params[:search])
    end
    @tasks = @tasks.page(params[:page]).per(PER)
  end

  def show
  end

  def new
    @task = @current_user.tasks.new
  end

  def create
    @task = @current_user.tasks.new(task_params)
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

  def permit_tasks_page?
    current_user
    redirect_to new_session_path unless @current_user
  end

  def edit_task?
    unless @task.user_id == @current_user.id
      redirect_to tasks_path
    end
  end
end
