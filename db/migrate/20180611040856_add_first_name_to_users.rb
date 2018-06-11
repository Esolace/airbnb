class AddFirstNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :name
    add_column :users, :last_name, :name
    add_column :users, :gender, :text
    add_column :users, :phone, :integer
    add_column :users, :country, :string
    add_column :users, :birthdate, :date
  end
end
