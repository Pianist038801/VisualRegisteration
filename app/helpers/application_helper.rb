module ApplicationHelper
  #
  # Return css class for errors if any for field
  #
  def error?(obj, field)
    'has-error' unless obj[field].blank?
  end

  #
  # Return Error text for field if any
  #
  def print_error(obj, field)
    return if obj[field].blank?
    "<label class=\"error\" >#{obj[field].uniq.join(', ')}</label>".html_safe
  end

  #
  # Return 'active' css class for selected menu item
  #
  def active_menu_class(menu, action = nil)
    if action.blank?
      (controller_name == menu ? 'active' : '')
    else
      ((controller_name == menu and action_name == action) ? 'active' : '')
    end
  end

  #
  ## Return Project listing
  #
  def option_for_select_project(company)
    company.projects.select(
      :id, :name
    ).map{ |project| [project.name, project.id] }
  end

  #
  ## Return Task listing
  #
  def option_for_select_task(project_id)
    Task.select(
      :id, :name
    ).where(
      project_id: project_id
    ).map{ |task| [task.name, task.id] }
  end

  #
  ## Return Line listing
  #
  def option_for_select_line
    Line.select(
      :id, :name
    ).map{ |line| [line.name, line.id] }
  end

  #
  ## Return User listing
  #
  def option_for_select_user(company_id)
    User.select(
      :id, :name
    ).where(
      company_id: company_id
    ).map{ |c| [c.name, c.id] }
  end

  #
  ## Return Pay Type listing
  #
  def option_for_select_pay_type
    PayType.select(
      :id, :description
    ).map{ |pt| [pt.description, pt.id] }
  end

  #
  ## Return Customer listing
  #
  def option_for_select_customer(company_id)
    Customer.select(
      :id, :name
    ).where(
      company_id: company_id
    ).map{ |c| [c.name, c.id] }
  end
end
