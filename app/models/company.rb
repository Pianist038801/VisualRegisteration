class Company < ApplicationRecord
  validates :name, presence: true

  has_many :customers
  has_many :projects, through: :customers
  has_many :tasks, through: :projects
  has_many :users
  has_many :company_settings
  has_many :hours, through: :users

  def to_s
    name
  end

  def self.get_organization_name(number)
    url = "http://data.brreg.no/enhetsregisteret/enhet/#{number}.json"
    company = JSON.parse(Net::HTTP.get(URI.parse(url)))
    unless company["navn"].blank?
      return company["navn"]
    else
      return nil
    end
  end

  def self.is_exist?(number)
    Company.where(organization_number: number).present?
  end

  def update_setting(setting)
    item = CompanySetting.find_or_initialize_by(company_id: self.id, item: setting[:item])
    item.value = setting[:value]
    item.save
  end
end
