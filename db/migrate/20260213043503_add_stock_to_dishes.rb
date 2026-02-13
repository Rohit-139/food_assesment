class AddStockToDishes < ActiveRecord::Migration[8.1]
  def change
    add_column :dishes, :stock, :integer
  end
end
