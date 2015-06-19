# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


require 'carrierwave/orm/activerecord' #to avoid the error with Recipe.all in rails console