class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all.order(created_at: 'DESC')
    @tasks = Task.all.order(deadline: 'ASC') if params[:sort_expired]
    search_tasks(params[:search]) if params[:search]
    # byebug
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
    params.require(:task).permit(:title, :detail, :deadline, :status)
  end

  def search_tasks(pr)
    if pr[:word].present? && pr[:status].present?
      tasks = Task.where("title LIKE ?", "%#{pr[:word]}%")
      @tasks = tasks.where(status: pr[:status])
    elsif pr[:word].present?
      @tasks = Task.where("title LIKE ?", "%#{pr[:word]}%")
    elsif pr[:status].present?
      @tasks = Task.where(status: pr[:status])
    end
  end
end
