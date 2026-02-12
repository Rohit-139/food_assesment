class AddAddressToRestaurant < ActiveRecord::Migration[8.1]
  def change
    add_column :restaurants, :street, :string
    add_column :restaurants, :city, :string
    add_column :restaurants, :state, :string
    add_column :restaurants, :latitude, :float
    add_column :restaurants, :longitude, :float
  end
end
