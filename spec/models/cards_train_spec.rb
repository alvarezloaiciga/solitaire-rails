require 'spec_helper'

describe CardsTrain, "#add_cards" do
  let(:cards) { [Card.create, Card.create] }

  it "persists the cards in the cards relationship" do
    subject.add_cards(cards)
    expect(subject.cards).to eq cards
  end
end

describe CardsTrain, "#active_card" do
  let(:card) { Card.create }

  let(:cards_cards_trains) {[ CardsCardsTrain.create(card: card) ]}

  context "when active position is nil" do
    subject { CardsTrain.create(cards_cards_trains: cards_cards_trains) }
    its(:active_card) { should be_nil }
  end

  context "when active position is not nil" do
    subject { CardsTrain.create(
      active_card_position: 0,
      cards_cards_trains: cards_cards_trains
    )}
    its(:active_card) { should eq card }
  end
end

describe CardsTrain, "#next_card" do
  context "when active_card_position is nil" do
    it "changes active_card_position to 0" do
      expect{
        subject.next_card!
      }.to change { subject.active_card_position }.from(nil).to(0)
    end
  end

  context "when active_card_position is the last card" do
    subject { CardsTrain.create(active_card_position: 0, cards: [Card.new]) }

    it "changes active_card_position to nil" do
      expect{
        subject.next_card!
      }.to change { subject.active_card_position }.from(0).to(nil)
    end
  end

  context "when active_card_position in between" do
    subject { CardsTrain.create(
      active_card_position: 0,
      cards: [Card.new, Card.new]
    )}

    it "increments active_card_position by 1" do
      expect{
        subject.next_card!
      }.to change { subject.active_card_position }.from(0).to(1)
    end
  end
end
