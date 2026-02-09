class RestaurantOrdersController < ApplicationController
  before_action :require_owner
  before_action :set_restaurant
  before_action :set_order, only: [ :show, :update_status ]

  # GET /restaurants/:restaurant_id/orders
  def index
    @orders = @restaurant.orders.order(created_at: :desc)
  end

  # GET /restaurants/:restaurant_id/orders/:id
  def show
  end

  # PATCH /restaurants/:restaurant_id/orders/:id/update_status
  def update_status
    if [ "accepted", "preparing", "delivered" ].include?(params[:status])
      @order.update(status: params[:status])
      redirect_to restaurant_order_path(@restaurant, @order),
                  notice: "Order status updated ✅"
    else
      redirect_to restaurant_order_path(@restaurant, @order),
                  alert: "Invalid status"
    end
  end

  private

  def set_restaurant
    @restaurant = current_user.restaurants.find(params[:restaurant_id])
  end

  def set_order
    @order = @restaurant.orders.find(params[:id])
  end
end
