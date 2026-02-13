class DishesController < ApplicationController
  before_action :require_owner
  before_action :set_dish, only: %i[edit update show destroy]

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @dishes = @restaurant.dishes
  end

  def new
    @dish = Dish.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @dish = @restaurant.dishes.new(dish_params)
    if @dish.save
      redirect_to restaurant_dishes_path(@restaurant)
    else
      flash.now[:alert] = @dish.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @dish.update(dish_params)
      redirect_to restaurant_dishes_path(params[:restaurant_id])
    else
      flash.now[:alert] = @dish.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
   
    @dish.destroy
    redirect_to restaurant_dishes_path(params[:restaurant_id])
  end

  def search
    search = params[:search]
    if params[:search].present?
      @restaurant = Restaurant.find(params[:restaurant_id])
      @dishes = @restaurant.dishes.where("name Ilike ? or description Ilike ?", "%#{search}%", "%#{search}%")
    else 
      @dishes = []
    end
  end
  private

  def dish_params
    params.require(:dish).permit(:name, :description, :price, :stock)
  end

  def set_dish
    @dish = Dish.find(params[:id])
  end

end
