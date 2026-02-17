class Order < ApplicationRecord
  belongs_to :customer, class_name: "User", foreign_key: "customer_id"
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy
  has_many :messages, dependent: :destroy

    enum :status, {
    pending: 0,     # order placed, waiting for owner
    accepted: 1,    # owner accepted
    preparing: 2,   # food is being prepared
    delivered: 3,   # completed
    cancelled: 4    # cancelled by customer/owner
  }


  validates :status, presence: true
  validates :total_amount,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
end
