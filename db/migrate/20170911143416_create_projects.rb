class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :reference_number
      t.belongs_to :customer, index: true
      t.timestamps
    end
  end
end
