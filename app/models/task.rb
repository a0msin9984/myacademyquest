class Task < ApplicationRecord
  validates :title, presence: true
  scope :active, -> { where(deleted: [ false, nil ]) }
end
