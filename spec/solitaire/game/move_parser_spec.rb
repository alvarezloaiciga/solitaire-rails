require 'solitaire/game/move_parser'
describe Solitaire::Game::MoveParser, "#origin" do
  let(:game) { double(:game) }
  let(:card) { double(:card) }
  let(:cards) { double(:cards_collection_proxy, find_by: card) }

  context "when origin is from feederline" do
    let(:columns) { double(:columns_collection_proxy, find_by: column) }
    let(:column) { double(:column) }

    let(:params){{
      origin: { column_id: "feeder_line_column_14", card_id: "card_12" }
    }}

    before do
      game.stub_chain(:feeder_line, :columns) { columns }

      allow(columns).to receive(:find_by) { column }
      allow(column).to receive(:cards) { cards }
    end

    it "gets the column from game's feeder line columns" do
      expect(columns).to receive(:find_by).with(id: '14')
      described_class.new(game, params).origin
    end

    it "gets the card from column" do
      expect(cards).to receive(:find_by).with(id: '12')
      described_class.new(game, params).origin
    end

    it "returns the origin hash" do
      origin = described_class.new(game, params).origin
      expect(origin).to eq({
        column: column,
        card: card
      })
    end
  end

  context "when origin is from train" do
    let(:params){{
      origin: { column_id: "train", card_id: "card_14" }
    }}

    let(:train) { double(:train, cards: cards) }

    before do
      allow(cards).to receive(:find_by) { card }
      allow(game).to receive(:cards_train) { train }
    end

    it "gets the card from game's train" do
      expect(cards).to receive(:find_by).with(id: '14')
      described_class.new(game, params).origin
    end

    it "returns the origin hash" do
      origin = described_class.new(game, params).origin
      expect(origin).to eq({
        column: train,
        card: card
      })
    end
  end
end

describe Solitaire::Game::MoveParser, "#destiny" do
  let(:game) { double(:game) }
  let(:card) { double(:card) }
  let(:cards) { double(:cards_collection_proxy, find_by: card) }

  context "when destiny is feederline" do
    let(:columns) { double(:columns_collection_proxy, find_by: column) }
    let(:column) { double(:column) }

    let(:params){{
      destiny: { column_id: "feeder_line_column_14", card_id: "card_12" }
    }}

    before do
      game.stub_chain(:feeder_line, :columns) { columns }

      allow(columns).to receive(:find_by) { column }
      allow(column).to receive(:cards) { cards }
    end

    it "gets the column from game's feeder line columns" do
      expect(columns).to receive(:find_by).with(id: '14')
      described_class.new(game, params).destiny
    end

    it "gets the card from column" do
      expect(cards).to receive(:find_by).with(id: '12')
      described_class.new(game, params).destiny
    end

    it "returns the origin hash" do
      destiny = described_class.new(game, params).destiny
      expect(destiny).to eq({
        column: column,
        card: card
      })
    end
  end

  context "when destiny is train" do
    let(:params){{
      destiny: { column_id: "train", card_id: "card_14" }
    }}

    let(:train) { double(:train, cards: cards) }

    it "gets the card from game's train" do
      parser = described_class.new(game, params)
      expect {
        parser.destiny
      }.to raise_error "Train is not valid as a destiny"
    end
  end
end
