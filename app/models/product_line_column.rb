class ProductLineColumn < ActiveRecord::Base
  has_many :cards_product_line_columns
  has_many :cards, through: :cards_product_line_columns
  belongs_to :product_line

  def add_cards_to_product_line(cards)
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

  def remove_cards_from_product_line(cards)
    self.cards.delete(cards)
    if last_position < first_active_card_position
      update(first_active_card_position: last_position)
    end
  end

  def cards_from(card)
    card_product_column = cards_product_line_columns.find_by(card_id: card.id)
    card_position = card_product_column.position
    cards_product_line_columns.where('position >= ?', card_position).map(&:card)
  end
end
