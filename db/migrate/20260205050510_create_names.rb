class CreateNames < ActiveRecord::Migration[8.1]
  def change
    create_table :restaurants do |t|
      t.text :description
      t.decimal :rating, precision:3, scale:2
      t.references :owner, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
