class FoodsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user

    if @food.save
      redirect_to foods_path, notice: 'Ingredient was successfully created.'
    else
      redirect_to new_food_path, alert: 'Cannot create a new ingredient.'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    redirect_to foods_path, notice: 'Food successfully deleted.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
