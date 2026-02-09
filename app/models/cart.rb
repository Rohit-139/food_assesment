class Cart < ApplicationRecord
  belongs_to :customer, class_name:'User', foreign_key: 'customer_id'
  has_many :cart_items, dependent: :destroy
  has_many :dishes, through: :cart_items
end
