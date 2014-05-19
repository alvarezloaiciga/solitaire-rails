class Card < ActiveRecord::Base
  has_many :cards_feeder_line_columns
  has_many :feeder_line_columns, through: :cards_feeder_line_columns

  has_many :cards_cards_trains
  has_many :cards_trains, through: :cards_cards_trains
  has_many :cards_product_line_columns
  has_many :product_line_columns, through: :cards_product_line_columns
end
