class PagesController < ApplicationController
  def home
    #redirect_to chef_path(current_user) if logged_in?
    redirect_to recipes_path if logged_in?
  end
  
  
end
