class StylesController < ApplicationController
 
  before_action :require_user, except: [:show]
  before_action :admin_user, only: [:edit, :update, :destroy]
  before_action :set_style, except: [:new,:create]
  
  
  
  def new
    @style = Style.new
  end
  
  def create
    @style = Style.new(style_params)
    if @style.save
      flash[:success] = "Your style has been created successfully"
      redirect_to recipes_path
      
    else
      render :new
    end
  end
  
  def show
   
   @recipes = @style.recipes.paginate(page: params[:page], per_page: 3)
  end
  
  
  def edit
    
    
  
  end
  
  def update
    
    
    if @style.update(style_params)
      flash[:success] = "Style has been edited successfully"
      redirect_to recipes_path
      
    else
      render :edit
    end
    
    
  end
  
  
  def destroy
    flash[:success] = " \"#{@style.name}\" is deleted successfully"
    Style.find(params[:id]).destroy
    
    redirect_to recipes_path
    
  end
  
  private
      def style_params
        params.require(:style).permit(:name)
      end
      
      def set_style
        @style = Style.find(params[:id])
      end
    
end