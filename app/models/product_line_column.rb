class ProductLineColumn < ActiveRecord::Base
  has_many :cards_product_line_columns
  has_many :cards, through: :cards_product_line_columns
  belongs_to :product_line
end
