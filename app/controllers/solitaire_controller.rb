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
    case params[:commit]
    when "Move Card(s)"
      action_card_mover(card_mover.move_between_columns)
    when "Move Card(s) to Product Line"
      action_card_mover(card_mover.move_to_product_line)
    when "Move Card(s) to Feeder Line"
      action_card_mover(card_mover.move_from_product_line)
    end
  end

  def action_card_mover(action)
    if action
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
