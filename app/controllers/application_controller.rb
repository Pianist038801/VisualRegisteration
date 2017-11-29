class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_company

  def current_company
    current_user.try(:company)
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_up_path_for(resource)
    new_user_session_path
  end

  def authenticate_admin!
    if current_user and current_user.admin?
      redirect_to dashboard_path, notice: "You are not authorized to access this page!"
    end
  end

  protected
  def set_peginate
    @per_page = params[:per_page].to_i <= 0 ? PER_PAGE : params[:per_page].to_i
    @page = params[:page].to_i <= 0 ? 1 : params[:page].to_i
  end

  def build_condition(field, column = nil, condition_type = '=', value = nil)
    @conditions ||= []
    column ||= field.to_s
    value ||= params[field]
    if params && value.present?
      @conditions[0] = @conditions[0].to_s +
                       (@conditions[0].blank? ? '' : ' and ') +
                       "#{column} #{condition_type} (?) "
      @conditions << case condition_type
                     when 'like'
                       "%#{value}%"
                     when '=', '!=', '>=', '<=', '>', '<', 'IN'
                       value
                     end
    end
    value
  end
end
