class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)
    @preparation_time_hours = @recipe.preparation_time_hours
    @preparation_time_minutes = @recipe.preparation_time_minutes
    @cooking_time_hours = @recipe.cooking_time_hours
    @cooking_time_minutes = @recipe.cooking_time_minutes
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to @recipe, notice: "Recipe is now #{@recipe.public ? 'public' : 'private'}"

    # if @recipe.update(public: !@recipe.public)
    #   render json: { public: @recipe.public }
    # else
    #   render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity
    # end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    @recipe.preparation_time = calculate_minutes(params[:recipe][:preparation_time_hr],
                                                 params[:recipe][:preparation_time_min])
    @recipe.cooking_time = calculate_minutes(params[:recipe][:cooking_time_hr], params[:recipe][:cooking_time_min])

    if @recipe.save
      redirect_to @recipe, notice: 'Recipe successfully created.'
    else
      render 'new', alert: 'Failed to create a new recipe.'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy!

    redirect_to recipes_path, notice: 'Recipe successfully deleted.'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :public)
  end

  def calculate_minutes(hours, minutes)
    (hours.to_i * 60) + minutes.to_i
  end
end
