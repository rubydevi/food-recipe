require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it 'is not valid without a name' do
    recipe = Recipe.new(description: 'A test recipe')
    expect(recipe).to_not be_valid
  end

  it 'is not valid without a description' do
    recipe = Recipe.new(name: 'Example Recipe')
    expect(recipe).to_not be_valid
  end
end
