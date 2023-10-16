# spec/models/recipe_food_spec.rb
require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  it 'is valid with valid attributes' do
    recipe = Recipe.create(name: 'Example Recipe', preparation_time: 30, cooking_time: 60, description: 'A test recipe')
    food = Food.create(name: 'Example Food', measurement_unit: 'kg', price: 2.99, quantity: 1)
    recipe_food = RecipeFood.new(quantity: 2, recipe:, food:)
    expect(recipe_food).to be_valid
  end

  it 'is not valid without a quantity' do
    recipe_food = RecipeFood.new(quantity: nil)
    expect(recipe_food).to_not be_valid
  end

  it 'is not valid without a recipe' do
    food = Food.create(name: 'Example Food', measurement_unit: 'kg', price: 2.99, quantity: 1)
    recipe_food = RecipeFood.new(quantity: 2, recipe: nil, food:)
    expect(recipe_food).to_not be_valid
  end

  it 'is not valid without a food' do
    recipe = Recipe.create(name: 'Example Recipe', preparation_time: 30, cooking_time: 60, description: 'A test recipe')
    recipe_food = RecipeFood.new(quantity: 2, recipe:, food: nil)
    expect(recipe_food).to_not be_valid
  end
end
