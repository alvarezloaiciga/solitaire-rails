class FeederLine < ActiveRecord::Base
  belongs_to :solitaire_game_id
  has_many :columns, class_name: 'FeederLineColumn', foreign_key: 'feeder_line_id'

  def add_lines(cards)
    1.upto(7)do |column_number|
      column = FeederLineColumn.new(number: column_number, first_active_card_position: column_number)
      cards_to_add = cards.pop(column_number)
      column.add_first_cards(cards_to_add)
      columns << column
    end
  end
end
