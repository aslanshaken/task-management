class Task < ApplicationRecord
  belongs_to :user, optional: true
  validates :title, presence: true
  validates :due_date, presence: true
end
