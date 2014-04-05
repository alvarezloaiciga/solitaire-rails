module Solitaire
  module Game
    class CardMover
      attr_reader :origin_card, :origin_column, :destiny_card, :destiny_column

      def initialize(opts={})
        @origin_column = opts[:origin][:column]
        @origin_card = opts[:origin][:card]
        @destiny_column = opts[:destiny][:column]
        @destiny_card = opts[:destiny][:card]
      end

      def move_cards
        if destiny_column.accept_move?(origin_card)
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
        destiny_column.add_cards(cards_to_move)
      end

      def moving_cards
        origin_column.cards_from(origin_card)
      end
    end
  end
end
