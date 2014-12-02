class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :description, :string
    add_column :users, :picture, :string
  end
end