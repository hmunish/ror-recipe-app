class RecipesController < ApplicationController
  def index
    @recipes = Recipe.includes(:user,
                               recipe_foods: [:food]).where(user_id: current_user.id).order(created_at: :desc)
  end

  def public
    @public_recipes = Recipe.includes(:user, recipe_foods: [:food]).where(public: true).order(created_at: :desc)
  end

  def new
    @user = current_user
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.includes(:user, recipe_foods: [:food]).find(params[:id])
    @recipe_food = @recipe.recipe_foods.includes(:food).order('foods.name ASC')
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to user_recipes_path(user_id: @recipe.user.id), notice: 'Recipe was successfully deleted.'
  end

  def public_toggle
    @recipe = Recipe.find(params[:id])
    @recipe.public = !@recipe.public
    @recipe.save
    redirect_to user_recipe_path(@recipe), notice: "The recipe is now #{@recipe.public ? 'public' : 'private'}"
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to user_recipes_path
    else
      render 'new'
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
