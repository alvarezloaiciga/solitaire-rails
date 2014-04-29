class CardsTrain < ActiveRecord::Base
  has_many :cards_cards_trains
  has_many :cards, through: :cards_cards_trains

  def add_cards(cards)
    self.cards << cards
  end

  def active_card
    if active_card_position
      ordered_cards_train = cards_cards_trains.order(:id)
      ordered_cards_train[active_card_position].card
    else
      nil
    end
  end

  def remove_cards(cards)
    self.cards.delete(cards)
    if active_card_position == 0
      update(active_card_position: nil)
    else
      decrement!(:active_card_position)
    end
  end

  def next_card!
    if cards.present?
      update(active_card_position: next_active_card_position)
    else
      update(active_card_position: nil)
    end
  end

  def used_cards
    if active_card_position
      ordered_cards_train = cards_cards_trains.order(:id)
      ordered_cards_train[0..active_card_position].map(&:card)
    end
  end

  def cards_from(card)
    [card]
  end

  def last_card?
    active_card_position >= cards.count-1
  end

  private
  def next_active_card_position
    return 0 unless active_card_position
    if last_card?
      update(times: 2)
      return nil
    end

    active_card_position + 1
  end

end
