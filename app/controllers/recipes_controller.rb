class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all #this @recipes will be passed to index page of recipe
  end
end
