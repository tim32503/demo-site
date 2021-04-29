class RestaurantsController < ApplicationController

  before_action :find_restaurant, only: [:show, :edit, :update, :destroy]
  before_action :check_user!, except: [:index, :show]

  def index 
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = @restaurant.comments.new
    @comments = @restaurant.comments.order(id: :desc)
  end

  def pocket_list
    @restaurant = Restaurant.find(params[:id])

    # 判斷名單是否存在
    if current_user.pocket_list.like?(@restaurant)
    # if (current_user.pocket_list.exists?(@restaurant.id))
      # 移除名單
      current_user.pocket_list.destroy(@restaurant)
      render json: {id: @restaurant.id, status: 'removed'}
    else
      # 加名單
      current_user.pocket_list << @restaurant
      rendor json: {id: @restaurant.id, status: 'added'}
    end

  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    # @restaurant = Restaurant.new(restaurant_params)
    # @restaurant.user = current_user

    @restaurant = current_user.restaurants.new(restaurant_params)

    if @restaurant.save
      redirect_to restaurants_path, notice: '餐廳已建立'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant), notice: '餐廳已修改成功'
      # redirect_to @restaurant 與上句相同
    else
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    # @restaurant.update(deleted_at: Time.now)
    redirect_to restaurants_path, notice: '餐廳已刪除'
  end

  def like?(restaurant)
    pocket_list.exists?(restaurant.id)
  end

  private
    def find_restaurant
      # 第一種方法
      # @restaurant = Restaurant.find_by!(
      #   id: params[:id],
      #   user_id: current_user.id
      # )

      # 第二種方法
      @restaurant = current_user.restaurants.find(params[:id])
    end

    def restaurant_params
      params.require(:restaurant).permit(:title, :address, :tel, :email, :description)
    end
end