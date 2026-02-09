class User < ApplicationRecord

	has_secure_password

	validates :name, :email, :type,  presence: true
	validates :name, length: { minimum: 3, maximum: 20 }
	validates :password , length: {minimum:8, maximum:15}
	validates :email, uniqueness: true , format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

end
