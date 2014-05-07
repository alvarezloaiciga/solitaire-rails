class SolitaireGame < ActiveRecord::Base
  before_create :init_everything

  has_one :feeder_line
  has_one :product_line
  has_one :cards_train

  def init_everything
    @cards = Card.all.shuffle!
    init_feeder_line
    init_product_line
    init_cards_train
  end

  def increment_score(chips)
    update(score: score + chips)
  end

  def decrement_score(chips)
    update(score: score - chips)
  end

  def increment_counter
    update(card_counter: card_counter + 1)
  end

  def decrement_counter
    update(card_counter: card_counter - 1)
  end

  def chips
    case card_counter
      when 1 .. 20
        8
      when 21 .. 40
        6
      when 41 .. 52
        4
    end
  end

  private
  def init_feeder_line
    self.feeder_line = FeederLine.new
    cards = @cards.pop(28)
    feeder_line.add_lines(cards)
  end

  def init_product_line
    self.product_line = ProductLine.new
    product_line.add_lines
  end

  def init_cards_train
    self.cards_train = CardsTrain.new
    cards_train.add_cards(@cards)
  end
end
