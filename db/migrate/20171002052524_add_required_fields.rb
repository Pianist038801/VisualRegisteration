class AddRequiredFields < ActiveRecord::Migration[5.1]
  def change
  	add_column :items, :line_id, :integer
  	add_column :items, :amount, :decimal
  	add_column :items, :pce, :string
  	add_column :hours, :line_id, :integer
  	add_column :projects, :line_id, :integer
  	add_column :tasks, :line_id, :integer

  	add_column :hours, :date, :datetime
  	add_column :hours, :time_from, :datetime
  	add_column :hours, :time_to, :datetime
  	add_column :hours, :amount, :decimal
  	add_column :hours, :paytype, :string
  end
end
