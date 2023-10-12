class ShoppingListController < ApplicationController
  def index
    @foods = current_user.foods
    @recipe_foods = current_user.recipes
    @shopping_list = @foods.where.not(id: @recipe_foods)
    @sum = 0
    @shopping_list.each do |food|
      @sum += food.price
    end
  end
end
