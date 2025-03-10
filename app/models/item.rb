# frozen_string_literal: true

class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :nullify

  validates :name, :price, :description, presence: true

  scope :oldest, -> { order(created_at: :asc) }
end
