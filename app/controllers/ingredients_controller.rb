class IngredientsController < ApplicationController
  
  before_action :require_user, except: [:show]
  before_action :admin_user, only: [:edit, :update, :destroy]
  before_action :set_ingredient, except: [:new,:create]
  
  
  
  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Your ingredient has been created successfully"
      redirect_to recipes_path
      
    else
      render :new
    end
  end
  
  def show
   
   @recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 3)
  end
  
  
  def edit
    
    
  
  end
  
  def update
    
    
    if @ingredient.update(ingredient_params)
      flash[:success] = "Ingredient has been edited successfully"
      redirect_to recipes_path
      
    else
      render :new
    end
    
    
  end
  
  
  def destroy
    flash[:success] = " \"#{@ingredient.name}\" is deleted successfully"
    Ingredient.find(params[:id]).destroy
    
    redirect_to recipes_path
    
  end
  
  private
      def ingredient_params
        params.require(:ingredient).permit(:name)
      end
      
      def set_ingredient
        @ingredient = Ingredient.find(params[:id])
      end
  
  
  
end