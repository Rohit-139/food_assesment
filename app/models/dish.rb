class Dish < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  validates :name, :price, :description, presence: true
  validates :name, length: { minimum: 3, maximum: 30 }
  validates :price, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10000
  }
  validates :stock, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100
  }
  before_validation :set_default_stock

   private
  def set_default_stock
    self.stock ||= 10
  end
end
