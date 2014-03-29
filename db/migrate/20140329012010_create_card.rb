class CreateCard < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :suit
      t.integer :value
    end
  end
end
