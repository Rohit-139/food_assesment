class WelcomeMailMailer < ApplicationMailer
	def welcome_user
		@user = params[:user]
		mail(to: @user.email, subject: 'Welcome to the application')
	end

	def order_recipt
		@order = params[:order]
		@total = params[:total]
		mail(to: @order.customer.email, subject: "Order Recipt")
	end
end
