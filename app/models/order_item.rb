class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :dish

   validates :quantity,
            presence: true,
            numericality: { greater_than: 0 }

  validates :price,
            presence: true,
            numericality: { greater_than: 0 }
end
