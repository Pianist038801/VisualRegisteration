class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:setting]

  def show
  end

  def edit
    current_user.company_name = current_company.name
  end

  def update
    respond_to do |format|
      if current_user.update_with_password(profile_params)
        format.html { redirect_to profile_path, notice: 'Profile updated successfully.' }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def company_setting
    @settings = current_company.company_settings.pluck(:item, :value).to_h
  end

  def update_company_setting
    params[:settings].each do |key, setting|
      current_company.update_setting(setting)
    end
    respond_to do |format|
      format.html { redirect_to profile_path, notice: 'Company settings updated successfully.' }
      format.json { render :show, status: :ok }
    end
  end

  private
    def profile_params
      params.require(:user).permit(:company_name, :name, :telephone, :current_password, :image,
                                   :current_password, :password, :password_confirmation)
    end
end
