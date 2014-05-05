class AddScoreToSolitaireGames < ActiveRecord::Migration
  def change
  	add_column :solitaire_games, :score, :int , :default => 0
  end
end
