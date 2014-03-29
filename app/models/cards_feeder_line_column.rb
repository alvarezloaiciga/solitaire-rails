class CardsFeederLineColumn < ActiveRecord::Base
  belongs_to :card
  belongs_to :feeder_line_column
end
