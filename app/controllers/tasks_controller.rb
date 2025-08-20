class TasksController < ApplicationController
  def index
    @tasks = Task.active.order(id: :desc)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      @tasks = Task.active
      respond_to do |format|
        format.turbo_stream  # ตอบกลับ turbo_stream
        format.html { redirect_to root_path }
      end
    else
      @tasks = Task.active
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("tasks_list", partial: "tasks/tasks_list", locals: { tasks: @tasks, task: @task }) }
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.update(deleted: true)
    @tasks = Task.active
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
