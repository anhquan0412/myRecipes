class Ingredient < ActiveRecord::Base
  has_many :recipes, through: :recipe_ingredients
  has_many :recipe_ingredients
  
  validates :name, presence: true, length: {minimum: 1, maximum: 25}
end