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
        origin_column.remove_cards(cards_to_move)
        if destiny_column.class == ProductLineColumn
          change_product_line(cards_to_move[0])
        end
        destiny_column.add_cards(cards_to_move)
      end

      def moving_cards
        origin_column.cards_from(origin_card)
      end

      def change_product_line(card)
        if card.on_product_line == false
          card.set_on_product_line
          game.set_counter
          game.set_score(destiny_column)
        end  
      end
    end
  end
end
