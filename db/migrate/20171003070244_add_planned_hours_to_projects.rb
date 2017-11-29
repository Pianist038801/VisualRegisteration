class AddPlannedHoursToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column  :projects, :planned_hours, :integer
  end
end
