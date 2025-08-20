require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is valid with a title" do
    task = Task.new(title: "My first task")
    expect(task).to be_valid
  end

  it "is invalid without a title" do
    task = Task.new(title: nil)
    expect(task).not_to be_valid
  end

  # ถ้ามี scope :active
  it "returns all tasks for active scope" do
    Task.create!(title: "Active task")
    expect(Task.all).to include(Task.first)
  end

  describe "#soft delete" do
    it "marks the task as deleted" do
      task = Task.create!(title: "Task to delete")
      task.update(deleted: true)
      expect(task.deleted).to eq(true)
    end
  end

  # Toggle completed
  describe "#toggle completed" do
    it "marks task as completed if it was incomplete" do
      task = Task.create!(title: "Incomplete task", completed: false)
      task.update(completed: !task.completed)
      expect(task.completed).to eq(true)
    end

    it "marks task as incomplete if it was completed" do
      task = Task.create!(title: "Completed task", completed: true)
      task.update(completed: !task.completed)
      expect(task.completed).to eq(false)
    end
  end
end
