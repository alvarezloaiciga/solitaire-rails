require 'solitaire/game/card_mover'
require 'spec_helper'
describe Solitaire::Game::CardMover, "#destiny column" do
  let(:game) { double(:game) }
  let(:card) { Card.create}
  let(:cards) { double(:cards_collection_proxy, find_by: card) }

  context "when origin is product line and destiny is feeder line" do
    let(:feeder_line_column) { double(:feeder_line_column, accept_move?: true, add_cards: card) }
    let(:product_line_column) { double(:product_line_column, cards_from: [card], remove_cards: card )}
    let(:params){ {
      origin: { column: product_line_column, card: card },
      destiny: { column: feeder_line_column, card: '6' }
    } }
    subject{ described_class.new(params) }
    its(:move_cards) { should == true }
  end

  context "when destiny is to product line" do
  end
end
