class OrdersController < ApplicationController
  before_action :require_customer
  def create
   cart = current_user.cart
   cart_items = cart.cart_items

   return redirect_to cart_path, alert: "Cart is empty" if cart_items.empty?

   restaurant = cart_items.first.dish.restaurant
   order = current_user.orders.create!(
              restaurant: restaurant,
              status: "pending",
              total_amount: 0)
    total = 0

    cart_items.each do |item|
      order.order_items.create!(
        dish: item.dish,
        quantity: item.quantity,
        price: item.dish.price
      )
      total += item.quantity * item.dish.price
    end
    order.update(total_amount: total)
    cart_items.destroy_all

    redirect_to order_path(order), notice: "Order placed successfully 🎉"
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def index
    @orders = current_user.orders
  end

  def cancel
    order = current_user.orders.find(params[:id])

    if order.status == "pending"
      order.update(status: "cancelled")
      redirect_to order_path(order), notice: "Order cancelled successfully ❌"
    else
      redirect_to order_path(order), alert: "You cannot cancel this order"
    end
  end
end
