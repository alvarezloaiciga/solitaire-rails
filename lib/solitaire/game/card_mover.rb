module Solitaire
  module Game
    class CardMover
      attr_reader :game, :origin_card, :origin_column, :destiny_card, :destiny_column

      def initialize(opts={})
        @game = opts[:game]
        @origin_column = opts[:origin][:column]
        @origin_card = opts[:origin][:card]
        @destiny_column = opts[:destiny][:column]
        @destiny_card = opts[:destiny][:card]
      end

      def move_cards
        if destiny_column.accept_move?(origin_card, origin_column)
          move
          true
        else
          false
        end
      end

      private

      def move
        cards_to_move = moving_cards
        if origin_column.class == ProductLineColumn
          decrement_score(cards_to_move)
        end
        origin_column.remove_cards(cards_to_move)
        destiny_column.add_cards(cards_to_move)
        if destiny_column.class == ProductLineColumn
          increment_score(cards_to_move)
        end
      end

      def moving_cards
        origin_column.cards_from(origin_card)
      end

      def increment_score(card)
        game.increment_counter
        score = game.chips
        if !game.all_aces_up && game.product_line.all_aces_up?
            game.all_aces_up = true
            game.save
        end
          game.bet += 8
          game.save
          game.increment_score(score)
      end
    end
  end
end
