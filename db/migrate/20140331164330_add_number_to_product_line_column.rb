class AddNumberToProductLineColumn < ActiveRecord::Migration
  def change
  	add_column :product_line_columns, :number, :integer
  end
end
