class CartsController < ApplicationController
  before_action :require_customer

  def show
    @cart_items = current_user.cart.cart_items
  end

 def add
  cart = current_user.cart
  cart_item = cart.cart_items.find_or_initialize_by(
    dish_id: params[:dish_id]
  )

  if cart_item.new_record?
    cart_item.save
  end
  redirect_to customers_path(params[:restaurant_id])
 end

 def increase
  item = CartItem.find(params[:id])
  if item.dish.stock > item.quantity
    item.quantity += 1
    item.save
    redirect_to cart_path
  else
    @cart_items = current_user.cart.cart_items
    flash.now[:alert] = "This item has only #{item.quantity} Stock right now"
    render :show, status: :unprocessable_entity
  end
 end

 def decrease
  item = CartItem.find(params[:id])
  if item.quantity > 1
    item.quantity -= 1
    item.save
  else
    item.destroy
  end
  redirect_to cart_path
 end

 def remove
  item = CartItem.find(params[:item_id])
  item.destroy
  redirect_to cart_path
 end
end
