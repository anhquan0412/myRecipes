class Recipe < ActiveRecord::Base
  belongs_to :chef
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many :styles, through: :recipe_styles #dont have to 'dependent: destroy' here
  has_many :recipe_styles, dependent: :destroy
  
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_ingredients, dependent: :destroy
  
  
  validates :name, presence: true,
                    length: {minimum: 5, maximum: 60}
  validates :summary, presence: true, 
                    length: {minimum: 5, maximum: 150}
  validates :description, presence: true, 
                    length: {minimum: 20, maximum: 5000}
  validates :chef_id, presence: true
  
  mount_uploader :picture, PictureUploader #PictureUploader is name of the class in picture_uploader.rb
  
  validate :picture_size #check pics size
  
  
  #order the recipe by update time
  default_scope -> {order(updated_at: :desc)}
  
  
  #order the recipe by upvote 
  #default_scope -> {order(likecount: :desc)}
  
  
  #count number of likes
  def thumbs_up_total
    self.likes.where(like: true).size
  end
  
  #count number of dislikes
  def thumbs_down_total
    self.likes.where(like: false).size
  end
  
  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5 MB")
      end 
    end
  
end
