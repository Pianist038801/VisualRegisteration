class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :reference_number
      t.belongs_to :company, index: true
      t.timestamps
    end
  end
end
