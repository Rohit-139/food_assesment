class Customers::DashboardController < ApplicationController
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
    else @restaurants = []
    end
  end
  
  def search_dish
    search = params[:search]
    if params[:search].present?
      @restaurant = Restaurant.find(params[:id])
      @dishes = @restaurant.dishes.where("name Ilike ? ", "%#{search}%")
    else @dishes = []
    end
  end
end
