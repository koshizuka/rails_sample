class TasksController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  skip_before_action :verify_authenticity_token

  def new
  end

  def edit
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find_by(id: params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find_by(id: params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @project, notice: '更新しました' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end


  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを登録しました！"
      redirect_to project_path(@task.project_id)
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def change_status
    @task = Task.find_by(id: params[:id])
    @project = Project.find_by(id: params[:project_id])
    if @task.not_started?
      @task.start
    elsif @task.working?
      @task.finish
    end
    @task.save
    redirect_to project_path(@project)
  end

  def destroy
    @task.destroy
    redirect_to root_url
  end

  def sort
    binding.pry
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
  end

  private

    def task_params
      params.require(:task).permit(:content, :id, :status, :planed_time, :actual_time, :project_id)
    end

    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      redirect_to root_url if @task.nil?
    end
end
