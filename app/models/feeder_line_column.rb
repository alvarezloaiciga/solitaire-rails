class FeederLineColumn < ActiveRecord::Base
  has_many :cards_feeder_line_columns
  has_many :cards, through: :cards_feeder_line_columns
  belongs_to :feeder_line

  default_scope -> { order(:number) }

  def add_first_cards(cards)
    1.upto(number) do |position|
      cards_feeder_line_columns << CardsFeederLineColumn.new(card: cards[position-1], position: position)
    end
  end

  def add_cards(cards)
    card_position = last_position + 1
    cards.count.times do |card_index|
      cards_feeder_line_columns << CardsFeederLineColumn.new(card: cards[card_index], position: last_position+card_position)
      card_position += 1
    end
  end

  def remove_cards(cards)
    self.cards.delete(cards)
    if last_position < first_active_card_position
      update(first_active_card_position: last_position)
    end
  end

  def last_position
    cards_feeder_line_columns.maximum(:position) || 0
  end

  def cards_from(card)
    card_feeder_column = cards_feeder_line_columns.find_by(card_id: card.id)
    card_position = card_feeder_column.position
    cards_feeder_line_columns.where('position >= ?', card_position).map(&:card)
  end
end
