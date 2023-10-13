require 'rails_helper'

RSpec.describe 'food#index', type: :feature do
  before(:each) do
    @user1 = User.create(
      id: 3,
      name: 'munish',
      email: 'munish@yahoo.com',
      password: 'munish579',
      confirmed_at: Time.now
    )

    sign_in @user1

    @foods = [
      Food.create(
        id: 1,
        user_id: @user1.id,
        name: 'sauce',
        measurement_unit: 'gms',
        quantity: 300,
        price: 200
      ),
      Food.create(
        id: 2,
        user_id: @user1.id,
        name: 'chicken',
        measurement_unit: 'gms',
        quantity: 700,
        price: 350
      )
    ]

    visit user_foods_url(user_id: @user1.id)
  end
  describe '#Indexpage' do
    it 'will be able to see the food name.' do
      @foods.each do |food|
        expect(page).to have_content(food.name)
      end
    end

    it 'will be able to see measurement_units' do
      @foods.each do |food|
        expect(page).to have_content(food.measurement_unit)
      end
    end

    it 'will be able to see the price' do
      @foods.each do |food|
        expect(page).to have_content(food.price)
      end
    end
  end

  describe 'GET new/page' do
    it 'when clicked add food, user redirected to form page.' do
      click_link('Add food')
      expect(page).to have_current_path(new_user_food_path(user_id: @user1.id))
    end
  end
end