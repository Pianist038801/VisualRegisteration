class AddPaytypeIdToHours < ActiveRecord::Migration[5.1]
  def change
    add_column :hours, :pay_type_id, :integer
    add_index  :hours, :pay_type_id
  end
end
