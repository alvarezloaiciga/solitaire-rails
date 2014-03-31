class CreateCardsCardsTrain < ActiveRecord::Migration
  def change
    create_table :cards_cards_trains do |t|
      t.integer :card_id
      t.integer :cards_train_id
    end
  end
end
