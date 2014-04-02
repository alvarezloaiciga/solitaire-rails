require 'solitaire/game/card_mover'
describe Solitaire::Game::CardMover, "#move_cards" do
  let(:destiny_column) { double(:destiny_column).as_null_object }
  let(:origin_column) { double(:origin_column).as_null_object }

  let(:origin_card) { double(:origin_card) }
  let(:destiny_card) { double(:destiny_card) }

  let(:params) {{
    origin: { column: origin_column, card: origin_card },
    destiny: { column: destiny_column, card: destiny_card }
  }}

  subject { described_class.new(params) }

  it "checks that destiny column accepts the move" do
    expect(destiny_column).to receive(:accept_move?).with(origin_card, destiny_card) { false }
    subject.move_cards
  end

  context "when destiny column accepts the move" do
    let(:cards_to_move) { [double(:card)] }
    let(:card) { double(:card) }

    before do
      allow(destiny_column).to receive(:accept_move?) { true }
      allow(origin_column).to receive(:cards_from) { cards_to_move }
    end

    it "gets the cards to move" do
      expect(origin_column).to receive(:cards_from).with(origin_card) { cards_to_move }
      subject.move_cards
    end

    it "removes the cards from the origin column" do
      expect(origin_column).to receive(:remove_cards).with(cards_to_move) { card }
      subject.move_cards
    end

    it "adds cards to destiny column" do
      expect(destiny_column).to receive(:add_cards).with(cards_to_move) { card }
      subject.move_cards
    end
    it "returns true" do
      expect(destiny_column).to receive(:accept_move?).with(origin_card, destiny_card)
      subject.move_cards
    end
  end

  context "when destiny column does not accept the move" do
    before do
      allow(destiny_column).to receive(:accept_move?) { false }
    end
    it "returns false" do
      expect(destiny_column).to receive(:accept_move?).with(origin_card, destiny_card)
      subject.move_cards
    end
  end
end
