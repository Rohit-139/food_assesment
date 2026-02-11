class User < ApplicationRecord

	after_create :create_customer_cart

	has_secure_password

	validates :name, :email, :type,  presence: true
	validates :name, length: { minimum: 3, maximum: 20 }
	validates :password , length: {minimum:8, maximum:15}
	validates :email, uniqueness: true , format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

	private
  def create_customer_cart
  	if self.type = "Customer"
  		@customer = User.find(self.id)
      @customer.create_cart 
    end
  end
end
