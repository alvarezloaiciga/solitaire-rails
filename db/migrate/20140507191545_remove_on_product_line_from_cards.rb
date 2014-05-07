class RemoveOnProductLineFromCards < ActiveRecord::Migration
  def change
  	remove_column :cards, :on_product_line
  end
end
