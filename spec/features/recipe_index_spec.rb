require 'rails_helper'

RSpec.describe 'Recipe Index Page', type: :feature do
  before(:each) do
    @user = User.create(id: 3, name: 'Ruby', email: 'ruby@mail.com', password: 'ruby123', confirmed_at: Time.now)

    sign_in @user

    @recipes = [
      Recipe.create(
        id: 1,
        user_id: @user.id,
        name: 'Apple Pie',
        preparation_time: 1,
        cooking_time: 3,
        description: 'Made with love and apples',
        public: true
      ),
      Recipe.create(
        id: 2,
        user_id: @user.id,
        name: 'Mashed Potatoes',
        preparation_time: 2,
        cooking_time: 1,
        description: 'Warm and creamy',
        public: false
      )
    ]

    visit recipes_path(user_id: @user.id)
  end
  describe 'GET /recipes' do
    it 'can see all the recipes added' do
      expect(@recipes.count).to eq(2)
    end

    it "can see each recipe's name." do
      @recipes.each do |recipe|
        expect(page).to have_content(recipe.name)
      end
    end

    it "can see each recipe's description." do
      @recipes.each do |recipe|
        expect(page).to have_content(recipe.description)
      end
    end

    it 'can see REMOVE button on each row' do
      @recipes.each do
        expect(page).to have_button('REMOVE')
      end
    end
  end

  describe 'GET recipe/id' do
    it "redirects on recipe/id when clicked on recipe's name" do
      recipe = @recipes.first
      click_link(recipe.name)
      expect(page).to have_current_path(recipe_path(recipe.id))
    end
  end
end
