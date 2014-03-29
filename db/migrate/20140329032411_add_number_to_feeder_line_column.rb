class AddNumberToFeederLineColumn < ActiveRecord::Migration
  def change
    add_column :feeder_line_columns, :number, :integer
  end
end
