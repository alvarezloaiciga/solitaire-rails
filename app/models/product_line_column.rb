class ProductLineColumn < ActiveRecord::Base
  has_many :cards_product_line_columns
  has_many :cards, through: :cards_product_line_columns
  belongs_to :product_line

  default_scope -> { order(:number) }

  def add_cards(cards)
    card_position = last_position
    cards.count.times do |card_index|
      card_position += 1
      cards_product_line_columns << CardsProductLineColumn.new(card: cards[card_index], position: last_position+card_position)
    end
    update(active_card_position: card_position - 1)
  end

  def ordered_cards
    @ordered_cards || cards_product_line_columns.map(&:card)
  end

  def last_position
   	return 0 if cards_product_line_columns.empty?
    return cards_product_line_columns.maximum(:position)
  end

  def remove_cards(cards)
    self.cards.delete(cards)
    if active_card_position == 0
      update(active_card_position: nil)
    else
      decrement!(:active_card_position)
    end
  end

  def cards_from(card)
    [card]
  end

  def accept_move?(origin_card, origin_column)
    destiny_card = cards_product_line_columns.last.try(:card)
    if destiny_card.nil? && !origin_card.nil?
      origin_card.value == 1
    elsif origin_card.nil?
      false
    else
      destiny_card.value + 1 == origin_card.value && destiny_card.suit == origin_card.suit && origin_column.cards_from(origin_card).size == 1
    end
  end
end
