class SolitaireGame < ActiveRecord::Base
  before_create :init_everything

  has_one :feeder_line

  def init_everything
    @cards = Card.all.shuffle!
    init_feeder_line
    #init_product_line
    #init_cards_train
  end

  private
  def init_feeder_line
    self.feeder_line = FeederLine.new
    cards = @cards.pop(28)
    feeder_line.add_lines(cards)
  end
end
