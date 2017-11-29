class Project < ApplicationRecord
  validates :name, :reference_number, presence: true

  has_many :items
  has_many :tasks
  has_many :hours
  belongs_to :customer

  def to_s
    name
  end

  def self.get_planned_and_total_hours(company)
    projects = company.projects.pluck(:id, :name, :planned_hours).map{ |p| [p[0], [p[1], p[2]]] }.to_h
    project_ids = projects.keys

    project_hours = Hour.select('project_id, SUM(TIME_TO_SEC(hours)) as id').where('project_id in (?)', project_ids).group(:project_id)
    project_hours.each do |hour|
      hours = Hour.convert_to_hours(hour.id)
      projects[hour.project_id] << "#{hours[0]}.#{hours[1]}"
    end

    return projects
  end
end
