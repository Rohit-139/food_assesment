class Customer <  User
  has_one :cart, foreign_key: "customer_id", dependent: :destroy
  has_many :orders, foreign_key: "customer_id", dependent: :destroy
  has_many :ratings, dependent: :destroy
end
