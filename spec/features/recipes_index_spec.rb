require 'rails_helper'

RSpec.describe 'recipe#index', type: :feature do
  before(:each) do
    @user1 = User.create(
      id: 3,
      name: 'Munish',
      email: 'munish@yahoo.com',
      password: 'munish@123',
      confirmed_at: Time.now
    )

    sign_in @user1

    @recipes = [
      Recipe.create(
        id: 1,
        user_id: @user1.id,
        name: 'wrap',
        preparation_time: 7,
        cooking_time: 15,
        description: 'descp1',
        public: true
      ),
      Recipe.create(
        id: 2,
        user_id: @user1.id,
        name: 'bry',
        preparation_time: 3,
        cooking_time: 5,
        description: 'descp2',
        public: true
      )
    ]

    visit user_recipes_url(user_id: @user1.id)
  end
  describe '#Indexpage' do
    it 'can see the recipe name.' do
      @recipes.each do |recipe|
        expect(page).to have_content(recipe.name)
      end
    end

    it 'can see the recipe description.' do
      @recipes.each do |recipe|
        expect(page).to have_content(recipe.description)
      end
    end

    it 'can see the recipe delete button' do
      @recipes.each do |_recipe|
        expect(page).to have_button('delete')
      end
    end
  end

end