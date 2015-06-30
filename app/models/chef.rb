class Chef < ActiveRecord::Base
  has_many :recipes
  has_many :likes
  before_save { self.email = self.email.downcase }
  validates :chefname, presence: true,
                    length: {minimum: 3, maximum: 40}
  
  #check email validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true,
                    length: {maximum: 105},
                    #uniqueness: true ; if we do this, abc@a.com and ABC@a.com are different, but in fact they are not => have to ignore case sensitivity
                    uniqueness: {case_sensitive: false},
                    format: { with: VALID_EMAIL_REGEX } 
                    
  #password authentication
  has_secure_password                
end
