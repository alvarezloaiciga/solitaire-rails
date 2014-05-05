class AddCardCounterToSolitaireGames < ActiveRecord::Migration
  def change
  	add_column :solitaire_games, :card_counter, :int , :default => 0
  end
end
