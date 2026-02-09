class AddNameToRestaurants < ActiveRecord::Migration[8.1]
  def change
    add_column :restaurants, :name , :string
  end
end
