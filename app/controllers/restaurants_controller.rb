class RestaurantsController < ApplicationController

  before_action :find_restaurant, only: [:show, :edit, :update, :destroy]

  def index 
    @restaurants = Restaurant.where(deleted_at: nil).order(id: :desc)
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      redirect_to "/restaurants"
    else
      render :new
    end

  end

  def show
  end

  def edit
    @restaurant
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant)
      # redirect_to @restaurant 與上句相同
    else
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    # @restaurant.update(deleted_at: Time.now)
    redirect_to restaurants_path
  end

  private
    def find_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    def restaurant_params
      params.require(:restaurant).permit(:title, :address, :tel, :email, :description)
    end

end