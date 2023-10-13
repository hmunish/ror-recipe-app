require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) do
    User.create(name: 'Munish Halai', email: 'munish@yahoo.com', password: 111333_777, confirmed_at: Time.now)
  end
  let(:recipe) do
    Recipe.create(name: 'Bry', preparation_time: '1 hour', cooking_time: '90 minutes',
                  description: 'Chicken', public: false, user:)
  end
  let(:food) do
    Food.create(name: 'rice', measurement_unit: 'kgs', price: 150,
                quantity: 1, user:)
  end
  context 'validations' do
    it 'is not valid without a food' do
      recipe_food = RecipeFood.new(recipe:, quantity: 2)
      expect(recipe_food).not_to be_valid
    end

  end
  context 'associations' do
    it 'belongs to recipe' do
      temp = RecipeFood.reflect_on_association(:recipe)
      expect(temp.macro).to eq(:belongs_to)
    end
    it 'belongs to food' do
      temp = RecipeFood.reflect_on_association(:food)
      expect(temp.macro).to eq(:belongs_to)
    end
  end
end