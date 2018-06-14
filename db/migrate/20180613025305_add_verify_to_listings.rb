class AddVerifyToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :verify, :boolean, default: false
  end
end
