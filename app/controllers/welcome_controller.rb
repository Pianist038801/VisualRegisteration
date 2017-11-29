class WelcomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  layout 'home', except: [:view, :dashboard]

  def index
  end

  def dashboard
    set_values
  end

  def set_values
    # Filters and Default Values
    @view         = params[:view] == "month" ? 'month' : 'week'
    @week_hours   = (CompanySetting.get_setting_value(current_company, 'WKHR') || 40).to_f
    @total_users  = current_user.admin? ? current_company.users.count : 1
    if @view == 'month'
      @start_date = Time.now.beginning_of_month
      @start_date = DateTime.parse(params[:month]) if params[:month]
      @start_date = @start_date.beginning_of_month
      @end_date = @start_date.end_of_month
      @last_end_date = @start_date - 1.seconds
      @last_start_date = @last_end_date.beginning_of_month
    else
      @start_date = Time.now.beginning_of_week
      @start_date = Date.strptime(params[:start_date], "%m/%d/%Y") if params[:start_date]
      @start_date = @start_date.beginning_of_week
      @end_date = @start_date.end_of_week
      @last_start_date = @start_date - 7.days
      @last_end_date = @end_date - 7.days
    end

    # Billable Hours and Stats
    total_billable_seconds = Hour.get_spent_seconds(current_user, current_company, @start_date, @end_date, true)
    @total_billable_hours = Hour.convert_to_hours(total_billable_seconds)
    total_last_billable_seconds = Hour.get_spent_seconds(current_user, current_company, @last_start_date, @last_end_date, true)
    @total_last_billable_hours = Hour.convert_to_hours(total_last_billable_seconds)
    @diff = Hour.get_difference(total_billable_seconds, total_last_billable_seconds)

    # Billings
    user_ids = [current_user.id]
    if current_user.admin?
      user_ids = current_company.users.pluck(:id)
    end

    @total_spent_hours = Hour.get_spent_hours(current_user, current_company, @start_date, @end_date)
    @goal_hours   = user_ids.count * @week_hours
    @total_hours  = Hour.get_real_value(@total_spent_hours)
    @sold_hours   = Hour.get_real_value(@total_billable_hours)

    #Projects
    @projects = Project.get_planned_and_total_hours(current_company)

    # Total
    @totals = Hour.get_billable_and_total_hours(current_company)

    #Hours
    if current_user.admin?
      @hours      = Hour.includes(:task,:project,:line).page(@page).per(@per_page)
    else
      @hours      = current_user.hours.includes(:task,:project,:line).page(@page).per(@per_page)
    end
  end
end
