class AddFirstActiveCardPositionToFeederLineColumn < ActiveRecord::Migration
  def change
    add_column :feeder_line_columns, :first_active_card_position, :integer
  end
end
