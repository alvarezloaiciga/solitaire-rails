class FeederLineColumn < ActiveRecord::Base
  BLACK_SUITS = %w( clubs spades )
  RED_SUITS = %w( diamonds hearts )

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

  def accept_move?(origin_card, origin_column)
    destiny_card = cards_feeder_line_columns.last.try(:card)
    if destiny_card.nil? && !origin_card.nil?
      origin_card.name == "K"
    elsif origin_card.nil? || origin_column.is_a?(ProductLineColumn)
      false
    else
      destiny_red = RED_SUITS.include?(destiny_card.suit)
      origin_red = RED_SUITS.include?(origin_card.suit)

      destiny_card.value == origin_card.value + 1 && destiny_red != origin_red
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
    cards_feeder_line_columns.where('position >= ?', card_position).order(:position).map(&:card)
  end
end
