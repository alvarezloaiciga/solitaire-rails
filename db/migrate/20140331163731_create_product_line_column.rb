class CreateProductLineColumn < ActiveRecord::Migration
  def change
    create_table :product_line_columns do |t|
      t.integer :product_line_id
    end

    add_index :product_line_columns, :product_line_id
  end
end
