class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  belongs_to :user
  belongs_to :task
end
