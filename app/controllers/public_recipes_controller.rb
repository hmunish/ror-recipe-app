class PublicRecipesController < ApplicationController
  def index
    @user = current_user
    @public_recipes = Recipe.includes(:user)
      .where(public: true)
      .order(created_at: :desc)
  end

  def show; end
end
