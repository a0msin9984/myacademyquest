require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  before do
    driven_by(:rack_test)  # ใช้ :selenium_chrome_headless ถ้าต้องการ browser จริง
  end

  it "creates a task via UI" do
    visit root_path
    fill_in "task_title", with: "Buy milk"
    find("[data-testid='add-task-btn']").click
    expect(page).to have_content("Buy milk")
  end

  it "shows error if title is blank" do
    visit root_path
    find("[data-testid='add-task-btn']").click
    expect(page).to have_content("Title can't be blank")
  end

  it "delete task " do
    visit root_path
      within find(".task-item", text: "Buy milk") do
      find("[data-testid='delete-task-btn']").click
  end

    expect(page).not_to have_content("Buy milk")
  end
end
