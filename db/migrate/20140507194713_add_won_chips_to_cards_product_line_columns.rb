class AddWonChipsToCardsProductLineColumns < ActiveRecord::Migration
  def change
  	add_column :cards_product_line_columns, :won_chips, :int , :default => 0
  end
end
