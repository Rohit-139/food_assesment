class Dish < ApplicationRecord
  belongs_to :restaurant
  validates :name, :price, :description ,presence: true
  validates :name, length: {minimum:3, maximum:30}
  validates :price, numericality: {  
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10000
  }
end
