class ProductLine < ActiveRecord::Base
  belongs_to :solitaire_game_id
  has_many :columns, class_name: 'ProductLineColumn', foreign_key: 'product_line_id'

  def add_lines
    1.upto(4)do |column_number|
      column = ProductLineColumn.new(number: column_number)
      columns << column
    end
  end

  def all_aces_up?
    columns.joins(:cards).where(cards: { name: "A" }).size == 4
  end

end
