require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /tasks" do
    it "returns http success" do
      get tasks_path
      expect(response).to have_http_status(:success)
    end

    it "assigns tasks" do
      task = Task.create!(title: "Task 1")
      get tasks_path
      expect(response.body).to include("Task 1")
    end
  end

  describe "POST /tasks" do
    it "creates a new task" do
      expect {
        post tasks_path, params: { task: { title: "New Task" } }
      }.to change(Task, :count).by(1)
      expect(response).to have_http_status(:created)
      expect(response.body).to include("New Task")
    end

    it "does not create task without title" do
      expect {
        post tasks_path, params: { task: { title: "" } }
      }.not_to change(Task, :count)
      expect(response).to have_http_status(:unprocessable_content)
    end
  end
end
