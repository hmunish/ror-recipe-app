require 'rails_helper'

RSpec.describe 'recipe#index', type: :feature do
  before(:each) do
    @user1 = User.create(
      id: 3,
      name: 'munish',
      email: 'munish@gmail.com',
      password: 'munish789',
      confirmed_at: Time.now
    )

    sign_in @user1

    @foods = [
      Food.create(
        id: 1,
        user_id: @user1.id,
        name: 'sauce',
        measurement_unit: 'gms',
        quantity: 50,
        price: 150
      ),
      Food.create(
        id: 2,
        user_id: @user1.id,
        name: 'samosa',
        measurement_unit: 'gms',
        quantity: 300,
        price: 150
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
        expect(page).to have_button('Delete')
      end
    end
  end

  describe 'GET show/page' do
    it 'When I click recipe name, I am redirected to that detailed page.' do
      recipe = @recipes.first
      click_link(recipe.name)
      expect(page).to have_current_path(user_recipe_path(id: recipe.id, user_id: recipe.user.id))
    end
  end
end
