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
end
