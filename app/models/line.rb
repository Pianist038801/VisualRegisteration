class Line < ApplicationRecord
  belongs_to :user

	has_many :hours
	accepts_nested_attributes_for :hours,:allow_destroy => true, :reject_if => lambda { |a| a[:hours].blank?  && a[:description].blank?}

	has_many :travels
	accepts_nested_attributes_for :travels,:allow_destroy => true, :reject_if => lambda { |a| a[:project_id].blank?  && a[:task_id].blank? && a[:location_from].blank?}

	has_many :items
	accepts_nested_attributes_for :items,:allow_destroy => true, :reject_if => lambda { |a| a[:project_id].blank?  && a[:task_id].blank? && a[:reference_number].blank?}

	has_many :requisitions
	accepts_nested_attributes_for :requisitions,:allow_destroy => true, :reject_if => lambda { |a| a[:project_id].blank?  && a[:task_id].blank?}
end
