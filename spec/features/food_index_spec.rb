require 'rails_helper'

RSpec.describe 'Foods index page', type: :feature do
  before(:each) do
    @user = User.create(id: 3, name: 'Ruby', email: 'ruby@mail.com', password: 'ruby123', confirmed_at: Time.now)

    sign_in @user

    @foods = [
      Food.create(id: 1, user_id: @user.id, name: 'apple', measurement_unit: 'kg', quantity: 1, price: 100),
      Food.create(id: 2, user_id: @user.id, name: 'potato', measurement_unit: 'kg', quantity: 1, price: 250),
      Food.create(id: 3, user_id: @user.id, name: 'rice', measurement_unit: 'kg', quantity: 3, price: 350)
    ]

    visit foods_path(user_id: @user.id)
  end

  describe 'Database content' do
    it 'can see all the foods' do
      expect(@foods.count).to eq(3)
    end

    it 'can see the food name.' do
      @foods.each do |food|
        expect(page).to have_content(food.name)
      end
    end

    it 'can see the measurement units' do
      @foods.each do |food|
        expect(page).to have_content(food.measurement_unit)
      end
    end

    it 'can see the price of food' do
      @foods.each do |food|
        expect(page).to have_content(food.price)
      end
    end
  end

  describe 'Add food button' do
    it 'redirects to new food path when Add Food button is clicked' do
      click_link('Add food')
      expect(page).to have_current_path(new_food_path)
    end
  end
end
