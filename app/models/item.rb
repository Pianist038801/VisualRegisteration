class Item < ApplicationRecord
  validates :reference_number, presence: true
  # validates :name, :reference_number, :supplier, presence: true
  validates_length_of :amount, :maximum => 500

  belongs_to :project, optional: true
  belongs_to :task, optional: true
  belongs_to :user, optional: true
end
