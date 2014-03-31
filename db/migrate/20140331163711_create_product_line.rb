class CreateProductLine < ActiveRecord::Migration
  def change
    create_table :product_lines do |t|
    	t.integer :solitaire_game_id
    end
  end
end
