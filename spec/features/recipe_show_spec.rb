require 'rails_helper'

RSpec.describe 'Recipe Show Page', type: :feature do
  before(:each) do
    @user = User.create(id: 3, name: 'Ruby', email: 'ruby@mail.com', password: 'ruby123', confirmed_at: Time.now)

    sign_in @user

    @recipe = Recipe.create(
      id: 1,
      user_id: @user.id,
      name: 'Apple Pie',
      preparation_time: 1,
      cooking_time: 3,
      description: 'Made with love and apples',
      public: true
    )

    visit recipe_url(id: @recipe.id, user_id: @recipe.user.id)
  end
  describe 'GET /recipes/1' do
    it 'can see preparation time of the recipe.' do
      expect(page).to have_content(@recipe.preparation_time)
    end

    it 'can see cooking time of the recipe.' do
      expect(page).to have_content(@recipe.cooking_time)
    end

    it 'can see description of the recipe.' do
      expect(page).to have_content(@recipe.description)
    end

    it 'can see Public content.' do
      expect(page).to have_content('Public')
    end

    it 'displays a functional "Generate Shopping List" link' do
      expect(page).to have_link('Generate shopping List', href: generate_shopping_lists_path(recipe_id: @recipe.id))
    end

    it 'displays a functional "Add Ingredient" link' do
      expect(page).to have_link('Add ingredient', href: new_recipe_recipe_food_path(@recipe.id))
    end
  end
end
