module Solitaire
  module Game
    class MoveParser

      def initialize(game, opts = {})
        @game = game
        @opts = opts
      end

      def origin
        params(:origin)
      end

      def destiny
        params(:destiny)
      end

      private
      def params(source)
        column = column(source)
        card_id = @opts[source][:card_id].match(/card_(\d+)/) ? $1 : nil
        card = column.cards.find_by(id: card_id) rescue nil
        { column: column, card: card }
      end

      def column(source)
        case @opts[source][:column_id]

        when /feeder_line_column_(\d+)/
          @game.feeder_line.columns.find_by(id: $1)

        when /product_line_column_(\d+)/
          @game.product_line.columns.find_by(id: $1)

        when /train_(\d+)/
          if source == :origin
            @game.cards_train
          else
            raise "Train is not valid as a destiny"
          end
        end
      end
    end
  end
end
