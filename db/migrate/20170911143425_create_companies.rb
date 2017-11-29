class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string  :name
      t.string  :organization_number
      t.boolean :registered, default: false

      t.timestamps
    end
  end
end
