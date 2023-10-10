class Recipe < ApplicationRecord
    belongs_to :user, foreign_key: :user_id
    has_many :recipe_food

    validates :name, presence: true
    validates :preparation_time, presence: true
    validates :cooking_time, presence: true
    validates :description, presence: true

    # Sum prices
    def self.total_price
      sum(:price)
    end
  end
