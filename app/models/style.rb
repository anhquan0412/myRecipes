class Style < ActiveRecord::Base
  has_many :recipes, through: :recipe_styles
  has_many :recipe_styles, dependent: :destroy
  
  
  validates :name, presence: true, length: {minimum: 1, maximum: 25}
  
  
end