class Recipe < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :name, :preparation_time, :cooking_time, :description, presence: true
  def total_price
    recipe_foods.sum { |fd| fd.quantity * fd.food.price }
  end
end
