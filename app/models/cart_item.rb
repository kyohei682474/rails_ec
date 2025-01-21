class CartItem < ApplicationRecord
  belogns_to :item
  belongs_to :cart
end
