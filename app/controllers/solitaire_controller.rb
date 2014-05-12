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
    respond_to do |f|
      if @card_moved = card_mover.move_cards
        f.js { render template: 'solitaire/moved_card' }
      else
        f.js { render template: 'solitaire/not_moved_card' }
      end
    end
  end

  def next_card
    @train = current_game.cards_train
      @train.next_card!
      respond_to do |f|
        f.js {}
      end
  end

  def score
    @game = current_game
    if request.xhr?
      render :json => @game.score
    end
  end

  private
  def current_game
    @game ||= SolitaireGame.find(params[:id])
  end

  def card_mover
    @card_mover ||= Solitaire::Game::CardMover.new(game: @game, origin: move.origin, destiny: move.destiny)
  end

  def move
    @move ||= Solitaire::Game::MoveParser.new(@game, params)
  end

end
