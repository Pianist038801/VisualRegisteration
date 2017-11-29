class Customer < ApplicationRecord
  validates :name, :reference_number, presence: true

  belongs_to :company, optional: true
  has_many :projects

  def to_s
    name
  end
end
