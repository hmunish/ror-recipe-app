require 'rails_helper'

RSpec.describe 'recipe#index', type: :feature do
  before(:each) do
    @user1 = User.create(
      id: 3,
      name: 'munish',
      email: 'munish@yahoo.com',
      password: 'munish123',
      confirmed_at: Time.now
    )

    sign_in @user1

    @recipes = [
      Recipe.create(
        id: 1,
        user_id: @user1.id,
        name: 'wrap',
        preparation_time: 75,
        cooking_time: 55,
        description: 'chicken',
        public: true
      ),
      Recipe.create(
        id: 2,
        user_id: @user1.id,
        name: 'roll',
        preparation_time: 75,
        cooking_time: 55,
        description: 'chicken',
        public: true
      )
    ]

    visit user_recipes_url(user_id: @user1.id)
  end
  describe '#Indexpage' do
    it 'will be able to see the recipe name.' do
      @recipes.each do |recipe|
        expect(page).to have_content(recipe.name)
      end
    end

    it 'will be able to see the recipe description.' do
      @recipes.each do |recipe|
        expect(page).to have_content(recipe.description)
      end
    end

    it 'will be able to see the recipe delete button' do
      @recipes.each do |_recipe|
        expect(page).to have_button('Delete')
      end
    end
  end

  describe 'GET show/page' do
    it 'When clicked on recipe name, User is redirected to detailed page.' do
      recipe = @recipes.first
      click_link(recipe.name)
      expect(page).to have_current_path(user_recipe_path(id: recipe.id, user_id: recipe.user.id))
    end
  end
end