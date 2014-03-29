class CreateSolitaireGames < ActiveRecord::Migration
  def change
    create_table :solitaire_games do |t|
      t.timestamps
    end
  end
end
