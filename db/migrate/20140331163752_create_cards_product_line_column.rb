class CreateCardsProductLineColumn < ActiveRecord::Migration
  def change
    create_table :cards_product_line_columns do |t|
      t.integer :card_id
      t.integer :product_line_column_id
      t.integer :position
    end
  end
end
