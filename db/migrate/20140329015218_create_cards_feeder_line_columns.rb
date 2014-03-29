class CreateCardsFeederLineColumns < ActiveRecord::Migration
  def change
    create_table :cards_feeder_line_columns do |t|
      t.integer :card_id
      t.integer :feeder_line_column_id
      t.integer :position
    end
  end
end
