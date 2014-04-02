require 'spec_helper'

describe SolitaireController, "GET new" do
  it "renders the new template" do
    get :new
    expect(response).to render_template("new")
  end

  it "creates a New Game" do
    expect(SolitaireGame).to receive(:new)
    get :new
  end
end

describe SolitaireController, "POST create" do
  let(:game) { double(:game).as_null_object }

  before { allow(SolitaireGame).to receive(:new) { game } }

  it "redirects to Show page" do
    post :create
    expect(response).to redirect_to game_show_path(game)
  end

  it "initializes the game" do
    expect(game).to receive(:init_everything)
    post :create
  end

  it "saves the game" do
    expect(game).to receive(:save)
    post :create
  end
end

describe SolitaireController, "GET show" do
  let(:game) { double(:game).as_null_object }

  before { allow(SolitaireGame).to receive(:find).with("#{game.id}") { game } }

  it "renders the show template" do
    get :show, id: game.id
    expect(response).to render_template("show")
  end

  it "finds the actual game" do
    expect(SolitaireGame).to receive(:find).with("#{game.id}")
    get :show, id: game.id
  end
end

describe SolitaireController, "POST move_card" do
  let(:game) { double(:game).as_null_object }
  let(:move_parser) { double(:move_parser, origin: {}, destiny: {}) }
  let(:card_mover) { double(:card_mover) }

  before do
    allow(SolitaireGame).to receive(:find).with("#{game.id}") { game }
    allow(Solitaire::Game::MoveParser).to receive(:new) { move_parser }
    allow(Solitaire::Game::CardMover).to receive(:new).with({ origin: move_parser.origin, destiny: move_parser.destiny }) { card_mover }
  end

  context "when moves cards" do
    before { allow(card_mover).to receive(:move_cards) { true } }

    it "redirects to Show page" do
      post :move_card, id: game.id
      expect(response).to redirect_to game_show_path(game)
    end
  end

  context "when does not move cards" do
    before { allow(card_mover).to receive(:move_cards) { false } }

    it "redirects to Show page with an alert" do
      post :move_card, id: game.id
      expect(flash[:alert]).to eq("You're stuck here!")
      expect(response).to redirect_to game_show_path(game)
    end
  end
end

describe SolitaireController, "POST next_card" do
  let(:cards_train) { double(:cards_train).as_null_object }
  let(:game) { double(:game, cards_train: cards_train).as_null_object }

  before { allow(SolitaireGame).to receive(:find).with("#{game.id}") { game } }

  it "redirects to Show page" do
    post :next_card, id: game.id
    expect(response).to redirect_to game_show_path(game)
  end

  it "changes the card" do
    expect(cards_train).to receive(:next_card!)
    post :next_card, id: game.id
  end

  it "finds the actual game" do
    expect(SolitaireGame).to receive(:find).with("#{game.id}")
    get :show, id: game.id
  end

end
