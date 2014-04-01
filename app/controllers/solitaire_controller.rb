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

  def move_to_product_line # Codigo nosotras
    if card_mover_to_product.move_to_product_line
        redirect_to game_show_path(@game)
      else
        redirect_to game_show_path(@game), alert: "You're stuck here!"
    end
  end

  def move_from_product_line # Codigo nosotras
    if card_mover_from_product.move_to_product_line
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

  # need to parse the hidden value that is feeder_line_column_<id>
  def column(type)
    column_id = params[type][:column_id].match(/feeder_line_column_(\d+)/) ? $1 : nil
    @game.feeder_line.columns.find_by(id: column_id)
  end

  # need to parse the hidden value that is card_<id>
  def card(type, column)
    card_id = params[type][:card_id].match(/card_(\d+)/) ? $1 : nil
    column.cards.find_by(id: card_id)
  end

  def card_mover_to_product
    origin_column = column(:origin)
    destiny_column = column_product_line(:destiny)

    origin_card = card(:origin, origin_column)
    destiny_card = card_product_line(:destiny, destiny_column)

    Solitaire::Game::CardMover.new(
      origin:  { card: origin_card,  column: origin_column  },
      destiny: { card: destiny_card, column: destiny_column }
    )
  end

  def column_product_line(type)
    column_id = params[type][:column_id].match(/product_line_column_(\d+)/) ? $1 : nil
    @game.product_line.columns.find_by(id: column_id)
  end

  def card_product_line(type, column)
    if column.cards.count > 0
      card_id = params[type][:card_id].match(/card_(\d+)/) ? $1 : nil
      column.cards.find(card_id)
    else
      nil
    end
  end

  def card_mover_from_product
    origin_column = column_product_line(:origin)
    destiny_column = column(:destiny)

    origin_card = card_product_line(:origin, origin_column)
    destiny_card = card(:destiny, destiny_column)

    Solitaire::Game::CardMover.new(
      origin:  { card: origin_card,  column: origin_column  },
      destiny: { card: destiny_card, column: destiny_column }
    )
  end
end
