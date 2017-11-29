class Hour < ApplicationRecord
  validates :hours, :description, presence: true

  belongs_to :user, optional: true
  belongs_to :project, optional: true
  belongs_to :task, optional: true
  belongs_to :line, optional: true
  belongs_to :pay_type, optional: true

  before_save :calculate_amount

  def self.get_spent_hours(user, company, start_date, end_date, billable = nil)
    return convert_to_hours(get_spent_seconds(user, company, start_date, end_date, billable))
  end

  def self.get_spent_seconds(user, company, start_date, end_date, billable = nil)
    project_ids = []
    user_ids = [user.id]
    if user.admin?
      if billable.nil?
        project_ids = company.projects.where(active: true).pluck(:id)
      elsif billable
        project_ids = company.projects.where(active: true, billable: true).pluck(:id)
      else
        project_ids = company.projects.where(active: true, billable: false).pluck(:id)
      end
      user_ids = company.users.pluck(:id)
    end
    return Hour.where('created_at >= ? and created_at <= ? and project_id in (?) and user_id in (?)', start_date, end_date, project_ids, user_ids).
          select('SUM(TIME_TO_SEC(hours)) as seconds')[0].attributes["seconds"].to_i
  end

  def self.convert_to_hours(seconds)
    return [seconds/3600, (seconds%3600)/60]
  end

  def self.get_hours_of_seconds(seconds)
    hours = self.convert_to_hours(seconds)
    "#{hours[0]}.#{(hours[1] * 100 / 60)}"
  end

  def self.get_difference(current_spent_seconds, last_spent_seconds)
    diff = current_spent_seconds >= last_spent_seconds ? 'positive' : 'negative'
    diff_value = ''
    if (current_spent_seconds == 0 and last_spent_seconds > 0) or
       (current_spent_seconds != 0 and last_spent_seconds == 0)
      diff_value = '100%'
    elsif current_spent_seconds == 0 and last_spent_seconds == 0
      diff_value = "0%"
    else
      diff_value = ((current_spent_seconds.to_f * 100) / last_spent_seconds).round(2).to_s + "%"
    end

    [diff, diff_value]
  end

  def self.get_real_value(hours)
    (((hours[1].to_f * 100)/60)/100 + hours[0]).round(2)
  end

  def self.get_billable_and_total_hours(company)
    all_project_ids = company.projects.where(active: true).pluck(:id)
    billable_project_ids = company.projects.where(active: true, billable: true).pluck(:id)

    total_hours = Hour.select('MONTH(created_at) as month, SUM(TIME_TO_SEC(hours)) as id').where('MONTH(created_at) > ? and project_id in (?)', Time.now.month - 3, all_project_ids).group('month')
    billable_hours = Hour.select('MONTH(created_at) as month, SUM(TIME_TO_SEC(hours)) as id').where('MONTH(created_at) > ? and project_id in (?)', Time.now.month - 3, billable_project_ids).group('month')

    values = {(Time.now.month - 3) => [(Time.now - 3.month).strftime('%B'), 0, 0],
              (Time.now.month - 2) => [(Time.now - 2.month).strftime('%B'), 0, 0],
              (Time.now.month - 1) => [(Time.now - 1.month).strftime('%B'), 0, 0],
              Time.now.month => [(Time.now).strftime('%B'), 0, 0] }

    total_hours.each do |total|
      values[total.attributes["month"]][1] = get_hours_of_seconds(total.id)
    end
    billable_hours.each do |billable|
      values[billable.attributes["month"]][1] = get_hours_of_seconds(billable.id)
    end

    values
  end

  def self.get_hours_of_days(days)
    return (days.to_f * 24).round(2)
  end

  def self.get_remaning_vacation_hours(user, company)
    vacation_time = get_vacation_hours(user, company)
    vacation_day = CompanySetting.get_setting_value(company, 'YRVC')
    lunch_time = CompanySetting.get_setting_value(company, 'LUTI')
    working_time = CompanySetting.get_setting_value(company, 'DAHR')
    working_hour = working_time.to_f - lunch_time.to_f

    return (vacation_day.to_f - (vacation_time.to_f / working_hour)).round(2)
  end

  def self.get_vacation_hours(user, company)
    return get_hours_of_seconds(get_vacation_second(user, company))
  end

  def self.get_vacation_second(user, company)
    vacation = PayType.find_by_description('Vacation')
    return 0 if vacation.nil?
    user.hours.where(pay_type_id: vacation.id).select('SUM(TIME_TO_SEC(hours)) as seconds')[0].attributes["seconds"].to_i
  end

  private
  def calculate_amount
    self.amount = ((self.time_to - self.time_from)/3600).round(2)
  end
end
