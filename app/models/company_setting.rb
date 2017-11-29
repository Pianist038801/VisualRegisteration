class CompanySetting < ApplicationRecord
  belongs_to :company

  def self.get_setting_value(company, setting)
    company.company_settings.find_by(item: setting).try(:value)
  end
end
