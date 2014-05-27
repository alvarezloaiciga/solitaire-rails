class AddBetToSolitaireGames < ActiveRecord::Migration
  def change
    add_column :solitaire_games, :bet, :integer, default: -52
  end
end
