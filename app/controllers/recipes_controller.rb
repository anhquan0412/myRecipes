class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all #this @recipes will be passed to index page of recipe
  end
  
  def show
    #binding.pry to hold the server (when the user click on the link to show recipe, server is put on hold)
    @recipe = Recipe.find(params[:id])
  end
  
  def new
    @recipe = Recipe.new
  end
  
  
  def create #to handle the submission of new recipe (form)
  #need strong parameter, need to process all the fields we submit by exclusively LIST them out as values so the apps can accept
  #need a private method
    @recipe = Recipe.new(recipe_params)
    
    #need a chef here, otherwise it will violate database integrity (chef_id must be present)
    #just temporary
    @recipe.chef = Chef.find(2)
    if @recipe.save
      flash[:success] = "Your Recipe was created successfully!" #this message is defined in _message.html.erb
      redirect_to recipes_path # REDIRECT_TO IS USED TO DIRECT TO A PATH/URL LINK
      #let's NOT use render here....
      
    else
      render :new #or render 'new'. RENDER IS USED TO DIRECT TO A HTML VIEW
      #redirect_to new_recipe_path #use redirect_to will wipe out all your input
    end
  end
  
  
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated succesfully!"
      redirect_to recipe_path(@recipe) #to SHOW the recipe based on its id
    else
      render :edit
    end
  end
  
  
  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description)
    end
end