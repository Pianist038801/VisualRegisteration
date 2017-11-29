class Task < ApplicationRecord
  validates :name, presence: true

  belongs_to :project
  has_many :hours
  has_many :items
end
