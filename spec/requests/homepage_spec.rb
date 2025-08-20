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
end
