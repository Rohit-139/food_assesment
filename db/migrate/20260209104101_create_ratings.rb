class CreateRatings < ActiveRecord::Migration[8.1]
  def change
    create_table :ratings do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: {to_table: :users}
      t.decimal :rating

      t.timestamps
    end
  end
end
