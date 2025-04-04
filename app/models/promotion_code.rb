# frozen_string_literal: true

class PromotionCode < ApplicationRecord
  validates :code, presence: true, uniqueness: true, length: { is: 7 }
  validates :discount_amount, presence: true,
                              numericality: { grater_than_or_equal_to: 100, less_than_or_equal_to: 1000 }
  validates :used, inclusion: { in: [true, false] }

  has_many :carts, dependent: :nullify

  def change_used_status
    update!(used: true)
  end
end
