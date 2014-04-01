class CardsCardsTrain < ActiveRecord::Base
  belongs_to :card
  belongs_to :cards_train
end
