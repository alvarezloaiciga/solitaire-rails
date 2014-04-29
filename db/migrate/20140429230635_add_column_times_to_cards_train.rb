class AddColumnTimesToCardsTrain < ActiveRecord::Migration
  def change
    add_column :cards_trains, :times, :integer , :default => 1
  end
end
