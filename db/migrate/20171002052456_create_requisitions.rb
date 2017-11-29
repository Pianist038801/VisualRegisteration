class CreateRequisitions < ActiveRecord::Migration[5.1]
  def change
    create_table :requisitions do |t|
      t.integer :user_id
      t.integer :line_id
      t.integer :project_id
      t.integer :task_id
      t.string :name
      t.string :reference_number
      t.string :supplier
      t.decimal :amount
      t.string :pce

      t.timestamps
    end
  end
end
