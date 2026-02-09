class DishesController < ApplicationController
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
    @dish = Dish.find(params[:id])
  end

  def update
    @dish = Dish.find(params[:id])
    @dish.update(dish_params)
    redirect_to restaurant_dishes_path(params[:restaurant_id])
  end

  def show
    @dish = Dish.find(params[:id])
  end

  def destroy
    @dish = Dish.find(params[:id])
    @dish.destroy
    redirect_to restaurant_dishes_path(params[:restaurant_id])
  end

  def search
    search = params[:search]
    if params[:search].present?
      @restaurant = Restaurant.find(params[:restaurant_id])
      @dishes = @restaurant.dishes.where("name Ilike ? or description Ilike ?", "%#{search}%", "%#{search}%")
    else @dishes = []
    end
  end
  private

  def dish_params
    params.require(:dish).permit(:name, :description, :price)
  end
end
