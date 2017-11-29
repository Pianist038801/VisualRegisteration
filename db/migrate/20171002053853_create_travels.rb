class CreateTravels < ActiveRecord::Migration[5.1]
  def change
    create_table :travels do |t|
      t.integer :user_id
      t.integer :line_id
      t.integer :task_id
      t.integer :project_id
      t.datetime :date
      t.string :location_from
      t.string :destination_to
      t.decimal :amount

      t.timestamps
    end
  end
end
