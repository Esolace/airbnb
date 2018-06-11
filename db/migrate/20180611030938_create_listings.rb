class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :name
      t.text :description
      t.text :property_type
      t.text :place_type
      t.integer :price
      t.text :address
      t.text :city
      t.text :state
      t.text :country
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
