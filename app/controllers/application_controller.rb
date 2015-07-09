class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #these functions below are available to the controller but not for the view folder
  #to make them available for view
  helper_method :current_user, :logged_in? 
  
  def current_user # check if the user can do authorized thing 
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id] # if the session exist
    # We will call this function a lot. Without the @current_user variable, every time we go to a new page 
    # (when logged in), this function will call the database to get the logged-in chef
    # So, the instant variable will store the chef. This is MEMORIZATION  
  end
  
  def logged_in? # check if the user is logged in or not
    !!current_user # using current_user function; return true if @current_user, which is returned from func current_user, is not null
  end
  
  def require_user
    if !logged_in?
      flash[:danger]="You must be logged in to perform that action"
      redirect_to :back ####
    end  
      
    rescue ActionController::RedirectBackError
    redirect_to root_path
    
  end
  
  
end
