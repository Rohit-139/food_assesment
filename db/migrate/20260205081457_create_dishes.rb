class CreateDishes < ActiveRecord::Migration[8.1]
  def change
    create_table :dishes do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
