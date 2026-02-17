class OrdersController < ApplicationController
  before_action :require_customer, except: [ :message, :message_save ]

  def preview
  cart = current_user.cart
  cart_items = cart.cart_items

  return render json: { error: "Cart empty" }, status: 422 if cart_items.empty?

  restaurant = cart_items.first.dish.restaurant

  items_total = 0
  cart_items.each do |item|
    items_total += item.quantity * item.dish.price
  end

  delivery_charge = calculate_distance_price(params[:latitude], params[:longitude])
  grand_total = items_total + delivery_charge


  session[:order_preview] = {
    latitude: params[:latitude],
    longitude: params[:longitude],
    delivery_charge: delivery_charge,
    total_amount: grand_total
  }

  render json: { redirect_url: "/orders/preview_page" }
end

def confirm
  data = session[:order_preview]
  return redirect_to cart_path, alert: "Session expired" unless data

  cart = current_user.cart
  cart_items = cart.cart_items
  restaurant = cart_items.first.dish.restaurant

  order = current_user.orders.create!(
    restaurant: restaurant,
    status: "pending",
    total_amount: 0
  )


  ActiveRecord::Base.transaction do
    cart_items.each do |item|
      dish = Dish.lock("FOR UPDATE").find(item.dish.id)
      if item.quantity <= item.dish.stock
        order.order_items.create!(
          dish: dish,
          quantity: item.quantity,
          price: dish.price
        )
      else
        flash.now[:notice]= "The stock is less than item quantity please wait sometime for stock fulfilling"
        render :preview_page, status: :unprocessable_entity and return
      end
    end

    order.update!(total_amount: data["total_amount"])
    remove_stock(cart_items)
    WelcomeMailMailer.with(order: order, total: data["total_amount"]).order_recipt.deliver_later
    cart_items.destroy_all
  end

  session.delete(:order_preview)
  redirect_to order_path(order), notice: "Order placed successfully 🎉"
end

  def preview_page
  @data = session[:order_preview]
  redirect_to cart_path, alert: "Session expired" unless @data
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

  def message
    @messages = Message.where(order_id: params[:id])
  end

  def message_save
    @message = Message.new(message_params)
    @message.order_id = params[:id]
    @message.user_id = current_user.id
    if @message.save
      redirect_to message_order_path
    else
      render :message_order, status: :unprocessable_entity
    end
  end

  private
  def message_params
    params.require(:orders).permit(:content)
  end

  def calculate_distance_price(latitude, longitude)
    delivery_charge = 0
     @restaurant = current_user.cart.cart_items.first.dish.restaurant
     distance = @restaurant.distance_to([ latitude, longitude ])

     if distance > 5
      delivery_charge = (distance-5)*10
      delivery_charge
     else
      delivery_charge
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
