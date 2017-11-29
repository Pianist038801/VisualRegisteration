class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :supplier
      t.string :reference_number
      t.belongs_to :user, index: true
      t.belongs_to :task, index: true, optional: true
      t.belongs_to :project, index: true, optional: true
      t.timestamps
    end
  end
end
