class RecipeFoodsController < ApplicationController
  def index; end

  def show; end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @foods = Food.all
    @recipe_food = RecipeFood.new
    @recipe_food.recipe = @recipe
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    if @recipe_food.save
      redirect_to user_recipe_url(current_user.id, @recipe_food.recipe.id),
                  notice: 'Recipe food was successfully added.'
    else
      flash[:error] = 'error while adding food.'
      @recipe = Recipe.find(params[:recipe_id])
      @foods = Food.all
      @recipe_food = RecipeFood.new
      @recipe_food.recipe = @recipe
      render :new
    end
  end

  def modify; end

  def destroy; end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:recipe_id, :food_id, :quantity)
  end
end
