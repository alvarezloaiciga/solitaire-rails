class CreateFeederLine < ActiveRecord::Migration
  def change
    create_table :feeder_lines do |t|
      t.integer :solitaire_game_id
    end
  end
end
