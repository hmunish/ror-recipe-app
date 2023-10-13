class Recipe < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  has_many :foods, through: :recipe_foods
  has_many :recipe_foods, dependent: :destroy

  validates :name, :preparation_time, :cooking_time, :description, presence: true
  def total_price
    recipe_foods.sum { |fd| fd.quantity * fd.food.price }
  end
end
