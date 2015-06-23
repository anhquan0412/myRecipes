class Like < ActiveRecord::Base
  belongs_to :chef
  belongs_to :recipe
  
  #check for uniqueness: customer can only like/dislike recipe once
  validates_uniqueness_of :chef, scope: :recipe
  #if just validates_uniqueness_of :chef, the chef/customer can only like/dislike ONCE for all
end
