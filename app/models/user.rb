# :nodoc:
class User < ApplicationRecord
  ## Devise Configuration
  devise  :database_authenticatable, :recoverable, :rememberable,
          :trackable, :validatable, :registerable, :confirmable

  attr_accessor :company_name, :organization_number

  belongs_to :company, optional: true
  has_many :hours
  has_many :items
  has_many :lines

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_attached_file :image,
    styles: { medium: '250x250#', thumb: '100x100#' },
    default_url: '/default/images/user/:style/user.png'

  validates_attachment_content_type :image,
    content_type: %r{\Aimage\/.*\z},
    with: %r{^balls/.+\.(gif|jpe?g|png|svg)$}i,
    message: ' and have an image extension'

  def create_company
    if company_name.present? and organization_number.present?
      return Company.create(name: company_name, organization_number: organization_number)
    end
  end
end
