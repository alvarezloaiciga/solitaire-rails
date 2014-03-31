module Solitaire
  module Game
    class CardMover

      BLACK_SUITS = %w( clubs spades )
      RED_SUITS = %w( diamonds hearts )

      attr_reader :origin_card, :origin_column, :destiny_card, :destiny_column

      def initialize(opts={})
        @origin_column = opts[:origin][:column]
        @origin_card = opts[:origin][:card]
        @destiny_column = opts[:destiny][:column]
        @destiny_card = opts[:destiny][:card]
      end

      def move_between_columns
        if able_to_move?
          move
          true
        else
          false
        end
      end

      def able_to_move?
        destiny_red = RED_SUITS.include?(destiny_card.suit)
        origin_red = RED_SUITS.include?(origin_card.suit)

        destiny_card.value == origin_card.value + 1 && destiny_red != origin_red
      end

      def move
        cards_to_move = moving_cards
        origin_column.remove_cards(cards_to_move)
        destiny_column.add_cards(cards_to_move)
      end

      def moving_cards
        origin_column.cards_from(origin_card)
      end





      def move_to_product_line
        if able_to_move_to_product_line?
          move_to_product_line_column
          true
        else
          false
        end
      end

      def able_to_move_to_product_line?
        if destiny_card.nil?
          true
        else
          destiny_red = RED_SUITS.include?(destiny_card.suit)
          origin_red = RED_SUITS.include?(origin_card.suit)

          destiny_card.value + 1 == origin_card.value && destiny_red == origin_red
        end
      end

      def move_to_product_line_column
        cards_to_move = moving_cards
        origin_column.remove_cards(cards_to_move)
        destiny_column.add_cards_to_product_line(cards_to_move)
      end
    end
  end
end
