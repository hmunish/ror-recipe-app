class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :password, presence: true
  validates :email, presence: true

  has_many :recipes, dependent: :destroy
  has_many :foods, dependent: :destroy
end
