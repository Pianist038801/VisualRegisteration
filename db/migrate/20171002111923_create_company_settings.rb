class CreateCompanySettings < ActiveRecord::Migration[5.1]
  def change
    create_table :company_settings do |t|
      t.belongs_to :company, index: true
      t.string  :item
      t.string  :code
      t.string  :value

      t.timestamps
    end
  end
end
