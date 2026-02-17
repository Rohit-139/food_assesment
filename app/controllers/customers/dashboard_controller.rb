class Customers::DashboardController < ApplicationController
  before_action :require_customer
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @dishes = @restaurant.dishes
  end

  def search
    search = params[:search]
    if params[:search].present?
      @restaurants = Restaurant.where("name Ilike ? ", "%#{search}%")
    else
      @restaurants = []
    end
  end

  def search_dish
    search = params[:search]
    if params[:search].present?
      @restaurant = Restaurant.find(params[:id])
      @dishes = @restaurant.dishes.where("name Ilike ? ", "%#{search}%")
    else
      @dishes = []
    end
  end

  def rating
    @rating = Rating.find_or_initialize_by(customer_id: current_user.id, restaurant_id: params[:id])
    @rating.rating = params[:rating]
    @rating.save
    update_rating_in_restaurant(params[:id])
  end

  private

  def update_rating_in_restaurant(id)
    average = Rating.where(restaurant_id: id).average(:rating)
    @restaurant = Restaurant.find(id)
    @restaurant.update(rating: average)
    redirect_to customers_dashboard_path
  end
end
