class AddAllAcesUpToSolitaireGames < ActiveRecord::Migration
  def change
    add_column :solitaire_games, :all_aces_up, :boolean, default: false
  end
end
