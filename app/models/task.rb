class Task < ApplicationRecord
  validates :title, presence: true
  scope :active, -> { all }
end
