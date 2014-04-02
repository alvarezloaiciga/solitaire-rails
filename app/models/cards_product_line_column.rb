class CardsProductLineColumn < ActiveRecord::Base
  belongs_to :card
  belongs_to :product_line_column
end
