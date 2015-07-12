class Comment < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :chef
  
  validates :recipe_id, presence: true
  validates :chef_id, presence: true
  validates :comment, presence: true
  
end