class ChefsController < ApplicationController
  # before_action :require_same_user #this mean require_same_user will be called before doing
  # any functions below: index, new, create....
  
  
  before_action :set_chef, only: [:edit, :update, :show]
  #the set_recipe action has to be placed before require_same_user, 
  #so require_same_user can have the instant variable it needs.
  
  
  
  before_action :require_same_user, only: [:edit, :update]
  
  
  
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 3)  
  end
  
  def new #register
    @chef = Chef.new
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Your account has been created successfully"
      session[:chef_id] = @chef.id #when account is created, user is logged in
      redirect_to recipes_path
    else
      render 'new'
    end
    
  end
  
  def edit
    #do set_chef
  end
  
  def update
    #do set_chef
    if(@chef.update(chef_params))
      flash[:success] = "Your account has been updated successfully"
      redirect_to chef_path(@chef)
    else
      render 'edit'
    end
  end
  
  def show
     #do set_chef
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end
  
  
  
  private
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)
    end
      
    def require_same_user
      if @chef != current_user
        flash[:danger] = "You can only edit your own profile"
        redirect_to :back #####
      end
      
      #if there is no back
      rescue ActionController::RedirectBackError
      redirect_to root_path
    end
    
    def set_chef
       @chef = Chef.find(params[:id])
    end
end