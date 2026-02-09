class ChangeDefaultOfRatingInRestaurant < ActiveRecord::Migration[8.1]
  def change
     change_column_default :restaurants, :rating, from: nil, to: 3
  end
end
