class AddOnProductLineToCards < ActiveRecord::Migration
  def change
  	add_column :cards, :on_product_line, :boolean , :default => false
  end
end
