class Card < ActiveRecord::Base
  has_many :cards_feeder_line_columns
  has_many :feeder_line_columns, through: :cards_feeder_line_columns
end
