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
    @game = SolitaireGame.find(params[:id])
  end

  def move_card
    @game = SolitaireGame.find(params[:id])
    if card_mover.move_between_columns
      redirect_to game_show_path(@game)
    else
      redirect_to game_show_path(@game), alert: "You're stuck here!"
    end
  end

  def next_card
    @game = SolitaireGame.find(params[:id])
    @game.cards_train.next_card!
    redirect_to game_show_path(@game)
  end

  private
  def card_mover
    move = Solitaire::Game::MoveParser.new(@game, params)
    Solitaire::Game::CardMover.new(origin: move.origin, destiny: move.destiny)
  end
end
