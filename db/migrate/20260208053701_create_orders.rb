class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: { to_table: :users }
      t.references :restaurant, null: false, foreign_key: true
      t.integer :status
      t.integer :total_amount

      t.timestamps
    end
  end
end
