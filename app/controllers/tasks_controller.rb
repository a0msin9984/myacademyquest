class TasksController < ApplicationController
  def index
    @tasks = Task.active # เอาเฉพาะที่ยังไม่ลบ
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      render :index, status: :created # 201
    else
      @tasks = Task.all.order(created_at: :desc)
      render :index, status: :unprocessable_content # แก้ deprecated
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.update(deleted: true)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path, notice: "Task was deleted." }
    end
  end

  def toggle
    @task = Task.find(params[:id])
    @task.update(completed: !@task.completed)
    redirect_to root_path
  end

  private
  def task_params
    params.require(:task).permit(:title)
  end
end
