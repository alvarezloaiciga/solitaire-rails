require 'solitaire/game/card_mover'
require 'solitaire/game/move_parser'

class SolitaireController < ApplicationController
  def new
    @game = SolitaireGame.new
  end

  def create
    @game = SolitaireGame.new
    @game.init_everything
    @game.save
    redirect_to game_show_path(@game)
  end

  def show
    @game = SolitaireGame.includes({
      cards_train: [:cards, :cards_cards_trains],
      feeder_line: { columns: [:cards, :cards_feeder_line_columns] },
      product_line: { columns: [:cards, :cards_product_line_columns] },
    }).find_by(id: params[:id])
  end

  def move_card
    @game = current_game
    if card_mover.move_cards
      redirect_to game_show_path(@game)
    else
      redirect_to game_show_path(@game), alert: "You're stuck here!"
    end
  end

  def next_card
    @game = current_game
    @game.cards_train.next_card!
    redirect_to game_show_path(@game)
  end

  private
  def current_game
    @game ||= SolitaireGame.find(params[:id])
  end

  def card_mover
    move = Solitaire::Game::MoveParser.new(@game, params)
    Solitaire::Game::CardMover.new(origin: move.origin, destiny: move.destiny)
  end
end
