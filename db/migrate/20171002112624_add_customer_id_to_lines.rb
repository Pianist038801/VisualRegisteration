class AddCustomerIdToLines < ActiveRecord::Migration[5.1]
  def change
  	add_column :lines, :customer_id,:integer
  	add_column :lines, :project_id,:integer
  	add_column :lines, :task_id,:integer
  end
end
