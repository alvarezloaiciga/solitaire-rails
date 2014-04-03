class ChangeLastActiveCardPositionInProductLineColumn < ActiveRecord::Migration
  def change
    rename_column :product_line_columns, :first_active_card_position, :active_card_position
  end
end
