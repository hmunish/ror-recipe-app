class Food < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  has_many :recipe, through: :recipe_foods
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true
  validates :measurement_unit, presence: true
  validates :quantity, presence: true

  # Sum prices
  def self.total_price
    sum(:price)
  end
end
