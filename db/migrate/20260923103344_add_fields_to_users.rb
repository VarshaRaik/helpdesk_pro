class AddFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :integer, default: 0
    add_column :users, :phone, :string
    add_column :users, :active, :boolean, default: true

    add_index :users, :role
    add_index :users, :phone
  end
end



