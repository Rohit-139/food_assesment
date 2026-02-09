class Customer <  User
  has_one :cart, foreign_key: "customer_id", dependent: :destroy
  has_many :orders, foreign_key: "customer_id", dependent: :destroy

  after_create :create_customer_cart

  private
  def create_customer_cart
    self.create_cart
  end
end
