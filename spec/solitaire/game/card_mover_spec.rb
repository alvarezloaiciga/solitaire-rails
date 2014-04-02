require 'solitaire/game/card_mover'

describe Solitaire::Game::CardMover, "#destiny column" do
  let(:game) { double(:game) }
  let(:card) { double(:card) }
  let(:cards) { double(:cards_collection_proxy, find_by: card) }

  context "when destiny is to feeder line" do
    let(:feeder_line_column) { double(:feeder_line_column, accept_move?: true)}
    let(:params){ {
      origin: { column: '13', card: '2' },
      destiny: { column: feeder_line_column, card: '6' }
    } }

    subject{ described_class.new(params)}

    its(:move_cards) { should == true }
  end

  context "when destiny is to product line" do
  end
end
