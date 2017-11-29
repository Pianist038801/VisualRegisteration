class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.belongs_to :user
      t.timestamps
    end
  end
end
