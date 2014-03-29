require 'solitaire/game/card_mover'

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

  def change_card
  end

  private
  def card_mover
    origin_column = column(:origin)
    destiny_column = column(:destiny)

    origin_card = card(:origin, origin_column)
    destiny_card = card(:destiny, destiny_column)

    Solitaire::Game::CardMover.new(
      origin:  { card: origin_card,  column: origin_column  },
      destiny: { card: destiny_card, column: destiny_column }
    )
  end

  # need to parse the hidden value that is feeder_line_column_<id>
  def column(type)
    column_id = params[type][:column_id].match(/feeder_line_column_(\d+)/) ? $1 : nil
    @game.feeder_line.columns.find_by(id: column_id)
  end

  # need to parse the hidden value that is card_<id>
  def card(type, column)
    card_id = params[type][:card_id].match(/card_(\d+)/) ? $1 : nil
    column.cards.find(card_id)
  end
end
