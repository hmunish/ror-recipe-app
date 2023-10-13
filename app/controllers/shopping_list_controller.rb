class ShoppingListController < ApplicationController
  def index
    @foods = Food.where.not(id: RecipeFood.select(:food_id))
    @sum = 0
    @foods.each do |food|
      @sum += food.price
    end
  end
end
