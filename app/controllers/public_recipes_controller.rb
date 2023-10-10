class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.where(public: false).order(created_at: :desc)
  end
end
