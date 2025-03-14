class PromotionCode < ApplicationRecord
  validates :code, presence: true, uniqueness: true, length: { is: 7 }
  validates :discount_amount, presence: true, numericality: { in 100..1000 }

end
