class CardsFeederLineColumn < ActiveRecord::Base
  belongs_to :card
  belongs_to :feeder_line_column

  default_scope -> { order(:position) }
end
