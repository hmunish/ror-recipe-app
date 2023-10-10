class User < ApplicationRecord
    validates :password, presence: true
  validates :email, presence: true

  has_many :recipes, dependent: :destroy
  has_many :foods, dependent: :destroy
end
