require 'rails_helper'

RSpec.describe "Homepage", type: :request do
  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it "returns tasks in the response body" do
      task = Task.create!(title: "Test task")
      get root_path
      expect(response.body).to include("Test task")
    end
  end

  describe "POST /" do
    it "creates a new task" do
      expect {
        post root_path, params: { task: { title: "New Task" } }
      }.to change(Task, :count).by(1)
    end

    it "does not create task without title" do
      expect {
        post root_path, params: { task: { title: "" } }
      }.not_to change(Task, :count)
    end
  end

  describe "DELETE /tasks/:id" do
    let!(:task) { Task.create!(title: "Test Task") }

    it "soft deletes the task" do
      delete task_path(task)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("Task was deleted.")
      expect(task.reload.deleted).to eq(true)
    end

    it "redirects to root path if task not found" do
      delete task_path(999)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq("Task not found")
    end

    it "does not delete if update fails" do
      allow_any_instance_of(Task).to receive(:update).and_return(nil)
      delete task_path(task)
      expect(task.reload.deleted).to eq(nil)
    end
  end
end
