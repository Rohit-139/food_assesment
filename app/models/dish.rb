class Dish < ApplicationRecord
  belongs_to :restaurant 
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  validates :name, :price, :description ,presence: true
  validates :name, length: {minimum:3, maximum:30}
  validates :price, numericality: {  
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10000
  }
end
