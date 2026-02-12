class RestaurantsController < ApplicationController
  before_action :authenticate_user
  before_action :require_owner
  before_action :set_restaurant, only: %i[show edit update destroy]

  def index
    @restaurants = current_user.restaurants
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)

    if @restaurant.save
      redirect_to restaurants_path, notice: "Restaurant created"
    else
      flash.now[:alert] = @restaurant.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to restaurants_path, notice: "Restaurant updated"
    else
      flash.now[:alert] = @restaurant.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_path, notice: "Restaurant deleted"
  end

  def show
    @dishes = @restaurant.dishes
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :street, :city, :state)
  end

  def set_restaurant
    @restaurant = current_user.restaurants.find(params[:id])
  end
end
