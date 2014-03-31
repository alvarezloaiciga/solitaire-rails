class CreateCardsTrain < ActiveRecord::Migration
  def change
    create_table :cards_trains do |t|
      t.integer :solitaire_game_id
      t.integer :active_card_position
    end
  end
end
