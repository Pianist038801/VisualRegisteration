class Users::RegistrationsController < Devise::RegistrationsController
  layout 'home'

  def create
    build_resource(registration_params)

    # Validate Resource
    if valid_company? and resource.save
      company = resource.create_company
      resource.update(company_id: company.id, admin: true) # Update post user information
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
      else
        respond_with resource, location: after_sign_up_path_for(resource)
      end
    else
      if resource.valid?
        resource.errors.add(:company_name, 'is exist or not valid')
        resource.errors.add(:organization_number, 'is exist or not valid')
      end
      flash[:alert] = 'Please fill correct information.'
      respond_with resource
    end
  end

  private
  def registration_params
    params.require(
      :user
    ).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :company_name,
      :organization_number
    )
  end

  def valid_company?
    company_name = Company.get_organization_name(resource.organization_number)
    if company_name.present? and !Company.is_exist?(resource.organization_number)
      resource.company_name = company_name
      return true
    else
      return false
    end
  end
end
