class Requisition < ApplicationRecord
  validates_length_of :amount, :maximum => 500
	
end
