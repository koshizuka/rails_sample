class TasksController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "Task created!"
      redirect_to project_path(@task.project_id)
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def change_status
    @task = Task.find_by(id: params[:id])
    if @task.not_started?
      @task.start
    elsif @task.working?
      @task.finish
    end
    @task.save
    redirect_to root_url
  end

  def destroy
    @task.destroy
    redirect_to root_url
  end

  private

    def task_params
      params.require(:task).permit(:content, :project_id)
    end

    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      redirect_to root_url if @task.nil?
    end
end
