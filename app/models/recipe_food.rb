class RecipeFood < ApplicationRecord
    belongs_to :food
    belongs_to :recipe

    validates :quantity, presence: true

    # Sum prices
    def self.total_price
      sum(:price)
    end
  end
