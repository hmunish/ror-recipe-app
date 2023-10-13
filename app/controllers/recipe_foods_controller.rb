class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_id: @recipe.id)
  end

  def create
    @recipe = Recipe.find(params[:recipe_food][:recipe_id])
    puts "Recipe ID: #{params[:recipe_id]}"
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)
    if @recipe_food.save
      flash[:notice] = 'Food created successfully.'
      redirect_to user_recipe_url(user_id: current_user.id, id: @recipe.id)
    else
      render :new
    end
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
  end

  def modify
    @recipe_food = RecipeFood.find(params[:id])
    puts "Form Data: #{params.inspect}"
    if @recipe_food.update(recipe_food_params)
      flash[:success] = 'Recipe Food updated successfully.'
    else
      flash[:danger] = 'Recipe Food not updated.'
    end
    redirect_to user_recipe_url(@recipe_food.recipe.user, @recipe_food.recipe)
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    flash[:success] = 'Recipe Food deleted successfully.'
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
