class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[public_recipies]

  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    @foods = Food.joins(:recipe_food).where(recipe_food: { recipe_id: @recipe.id }).includes([:recipe_food])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to user_recipes_path, notice: 'Recipe was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def public_recipies
    @public = Recipe.where(public: true).includes([:user]).includes([:recipe_foods]).order('created_at DESC')
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    @recipe_foods = @recipe.recipe_food
    @recipe_foods.destroy_all

    if @recipe.destroy
      redirect_to user_recipes_path, notice: 'Recipe was successfully deleted.'
    else
      redirect_to user_recipes_path, alert: 'There was an error deleting the Recipe.'
    end
  end

  def update
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.public = !@recipe.public
    if @recipe.save
      redirect_to(request.referrer || root_path)
    else
      flash[:error] = 'Error updating recipe'
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
