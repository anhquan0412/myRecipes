class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe, touch: true #the time will update when adding/editing ingredient or style
  belongs_to :ingredient
end