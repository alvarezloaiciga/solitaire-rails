class CreateFeederLineColumn < ActiveRecord::Migration
  def change
    create_table :feeder_line_columns do |t|
      t.integer :feeder_line_id
    end

    add_index :feeder_line_columns, :feeder_line_id
  end
end
