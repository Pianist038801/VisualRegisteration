class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column      :users, :telephone, :string
    add_column      :users, :admin,     :boolean, default: false
    add_attachment  :users, :image
  end
end
