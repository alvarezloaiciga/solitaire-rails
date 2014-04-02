class ProductLineColumn < ActiveRecord::Base
  has_many :cards_product_line_columns
  has_many :cards, through: :cards_product_line_columns
  belongs_to :product_line

  default_scope -> { order(:number) }

  def add_cards(cards)
    card_position = last_position + 1
    cards.count.times do |card_index|
      cards_product_line_columns << CardsProductLineColumn.new(card: cards[card_index], position: last_position+card_position)
      card_position += 1
    end
    update(first_active_card_position: card_position - 1)
  end

  def last_position
   	return 0 if cards_product_line_columns.empty?
    return cards_product_line_columns.maximum(:position)
  end

  def remove_cards(cards)
    self.cards.delete(cards)
    if last_position < first_active_card_position
      update(first_active_card_position: last_position)
    end
  end

  def cards_from(card)
    [card]
  end

  def accept_move?(origin_card, destiny_card)
    if destiny_card.nil? && !origin_card.nil?
      origin_card.value == 1
    elsif origin_card.nil?
      false
    else
      destiny_card.value + 1 == origin_card.value && destiny_card.suit == origin_card.suit
    end
  end
end
