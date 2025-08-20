class HomepageController < ApplicationController
  def index
    @tasks = Task.active.order(created_at: :desc)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to root_path
    else
      @tasks = Task.active.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.update(deleted: true)
    redirect_to root_path, notice: "Task was deleted."
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Task not found"
  end


  private
  def task_params
    params.require(:task).permit(:title)
  end
end
