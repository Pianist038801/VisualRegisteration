class CreateHours < ActiveRecord::Migration[5.1]
  def change
    create_table :hours do |t|
      t.time :hours
      t.string :description
      t.belongs_to :user, index: true
      t.belongs_to :project, index: true
      t.belongs_to :task, index: true, optional: true
      t.timestamps
    end
  end
end
