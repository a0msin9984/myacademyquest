require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  # describe "GET /tasks" do
  #   it "returns http success" do
  #     get tasks_path
  #     expect(response).to have_http_status(:success)
  #   end

  #   it "assigns tasks" do
  #     task = Task.create!(title: "Task 1")
  #     get tasks_path
  #     expect(response.body).to include("Task 1")
  #   end
  # end

  # describe "POST /tasks" do
  #   it "creates a new task" do
  #     expect {
  #       post tasks_path, params: { task: { title: "New Task" } }
  #     }.to change(Task, :count).by(1)
  #     expect(response).to have_http_status(:created)
  #     expect(response.body).to include("New Task")
  #   end

  #   it "does not create task without title" do
  #     expect {
  #       post tasks_path, params: { task: { title: "" } }
  #     }.not_to change(Task, :count)
  #     expect(response).to have_http_status(:unprocessable_content)
  #   end
  # end

  let!(:task) { Task.create!(title: "Test Task") }
  describe "DELETE /tasks/:id" do
    it "soft deletes the task" do
      task = Task.create!(title: "Test Task") # deleted จะเป็น false เริ่มต้น
      expect {
        delete task_path(task)
        task.reload
      }.to change { task.deleted }.from(nil).to(true)
    end

    it "redirects to root path with notice" do
      delete task_path(task)
      expect(flash[:notice]).to eq("Task was deleted.")
      expect(response).to redirect_to(root_path)
    end
  end

  describe "PATCH /tasks/:id/toggle" do
    it "toggles task from incomplete to complete" do
      patch toggle_task_path(task)
      expect(response).to redirect_to(root_path)
      expect(task.reload.completed).to eq(true)
    end

    it "toggles task from complete to incomplete" do
      task.update(completed: true)
      patch toggle_task_path(task)
      expect(response).to redirect_to(root_path)
      expect(task.reload.completed).to eq(false)
    end
  end
end
