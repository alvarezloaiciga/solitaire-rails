class AddFirstActiveCardPositionToProductLineColumn < ActiveRecord::Migration
  def change
  	add_column :product_line_columns, :first_active_card_position, :integer
  end
end
