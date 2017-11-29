class PayType < ApplicationRecord
  validates :description, presence: true

  has_many :hours
end
