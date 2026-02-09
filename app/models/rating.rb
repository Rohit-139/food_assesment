class Rating < ApplicationRecord
  belongs_to :restaurant
  belongs_to :customer, class_name:'User', foreign_key: 'customer_id'

  validates :rating , presence: true
end
