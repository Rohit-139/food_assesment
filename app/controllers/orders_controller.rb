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

  #Implement lock for deadlock condition  and mantain the integrity 

  ActiveRecord::Base.transaction do 
    begin
    cart_items.each do |item|
      dish = Dish.lock("FOR UPDATE").find(item.dish.id)
      order.order_items.create!(
        dish: dish,
        quantity: item.quantity,
        price: dish.price
      )
      total += item.quantity * dish.price
    end
    delivery_charge = calculate_distance_price(params[:longitude],params[:latitude])

    if order.update(total_amount: total+delivery_charge)
      remove_stock(cart_items)
      cart_items.destroy_all
      render json: {location: order_path(order)}, status: :created
    else
      render json: {erors: order.errors.full_messages}, status: :unprocessable_entity
    end

    rescue ActiveRecord::LockWaitTimeout => e
      flash[:alert] = "Could not acquire lock to order the dish. Please try again."
    end

  end

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

  private 

  def calculate_distance_price(longitude,latitude)

    delivery_charge = 0
     @restaurant = current_user.cart.cart_items.first.dish.restaurant
     distance = @restaurant.distance_to([latitude, longitude])

     if distance > 5
      delivery_charge = (distance-5)*10
      return delivery_charge
    else
      return delivery_charge
    end
  end

  def remove_stock(cart_items)
    cart_items.each do |item|
      @dish = item.dish
      @dish.stock -= item.quantity
      @dish.save
    end
  end
end
