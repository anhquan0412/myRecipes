class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :like, :comment, :destroy, :deletecomment]
  #the set_recipe action has to be placed before require_same_user, 
  #so require_same_user can have the instant variable it needs.
  
  before_action :require_user, except: [:show, :index] #only for new, create ....User has to log in to perform these actions
  #this is defined in application_controller
  
  before_action :require_same_user, only: [:edit, :update]
  
  before_action :admin_user, only: [:destroy]
  #defined in application_controller
  
  
  
  def index
    
     #  @recipes = Recipe.all.sort_by{ |likes| likes.thumbs_up_total}.reverse #sorting in descending order with number of thumbs up
     #this @recipes will be passed to index page of recipe
     #not a good idea, might cause performance issue when loading ALL recipes
    
    #using paginate
    if (params[:order])
      temp = params[:order]
      if (temp == '1') #sort by most recent/default
        @recipes = Recipe.paginate(page: params[:page], per_page: 5)
        #flash[:success]="most recent"
      else
        if(temp == '2') #sort by likes
          sql = "SELECT recipes.* FROM recipes   ORDER BY likecount DESC, recipes.created_at DESC"
          @recipes = Recipe.paginate_by_sql(sql,page: params[:page], per_page: 5)
          #flash[:success]="most likes"
        else #sort by comments
          sql = "SELECT recipes.* FROM recipes   ORDER BY commentcount DESC, recipes.created_at DESC"
          @recipes = Recipe.paginate_by_sql(sql,page: params[:page], per_page: 5)
          #flash[:success]="most comments"
        end  
      end 
    
    else
      @recipes = Recipe.paginate(page: params[:page], per_page: 5)
      #flash[:success]="default"
      
    end
    
    
  end
  
  
  
  def new
    @recipe = Recipe.new
  end
  
  
  def create #to handle the submission of new recipe (form)
  #need strong parameter, need to process all the fields we submit by exclusively LIST them out as values so the apps can accept
  #need a private method
    @recipe = Recipe.new(recipe_params)
    
    #initialize likecount
    @recipe.likecount = 0
    @recipe.commentcount = 0
    
    
    #need a chef here, otherwise it will violate database integrity (chef_id must be present)
    
    @recipe.chef = current_user
    if @recipe.save
      flash[:success] = "Your Recipe was created successfully!" #this message is defined in _message.html.erb
      redirect_to recipes_path # REDIRECT_TO IS USED TO DIRECT TO A PATH/URL LINK
      #let's NOT use render here....
      
    else
      render :new #or render 'new'. RENDER IS USED TO DIRECT TO A HTML VIEW
      #redirect_to new_recipe_path #use redirect_to will wipe out all your input
    end
  end
  
  
  def show
    #binding.pry #to hold the server (when the user click on the link to show recipe, server is put on hold)
    
    #do set_recipe
    
    
    # this is like new function in comments controller
    @comment = Comment.new
    
    #index
    
    #sql =  "SELECT comments.* FROM comments WHERE comments.recipe_id = #{@recipe.id} ORDER BY comments.created_at ASC"
    
    #to show the last page of comments always
    temps = @recipe.comments
    if (params[:page])
      @comments = temps.paginate(:page => params[:page], :per_page => 5)
      
    else
      last_page = temps.paginate(:page => params[:page], :per_page => 5).total_pages
      @comments = temps.paginate(:page => last_page, :per_page => 5)
    end
    
    
    
  end
  
  #### COMMENT METHOD ####
  def comment # create comment
    
    @comment = Comment.new(comment_params)
    @comment.chef = current_user
    @comment.recipe = @recipe
    
    if @comment.save
      flash[:success] = "Comment Successfully!"
      @recipe.commentcount = @recipe.commentcount + 1
      @recipe.save
    else
      flash[:danger] = "Invalid comment length!"
      
    end
    redirect_to recipe_path(@recipe)
  end
  
  def deletecomment
    comment = Comment.find(params[:comment_id])
    if(current_user.admin? or comment.chef == current_user)
    
      flash[:success] = " Your comment is deleted successfully"
      comment.destroy
      @recipe.commentcount = @recipe.commentcount - 1
      @recipe.save
    
    else
      flash[:danger] = "You cannot delete other user's comment!"
    end
    
    redirect_to recipe_path(@recipe)
  end
  
  
  
  def edit
    #do set_recipe
  end
  
  
  def update
    #do set_recipe
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated succesfully!"
      redirect_to recipe_path(@recipe) #to SHOW the recipe based on its id
    else
      render :edit
    end
  end
  
  #define like method, THIS IS CONFUSING, PLS REVIEW MULTIPLE TIMES
  def like
    temp = params[:like]
    #do set_recipe
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    
    if like.valid? #check validation
    
    #params[:like] would return true if thumb-up, false if thumb-down, this is passed here from show.html.erb
      if temp == 'true'
        #update likecount to database here
        @recipe.likecount = @recipe.likecount + 1
        #@recipe.likecount = @recipe.thumbs_up_total
        @recipe.save
        #
        flash[:success] = "You liked \"#{@recipe.name}\" recipe!"
      else
        flash[:success] = "You disliked \"#{@recipe.name}\" recipe!"
      end
      
    else
      flash[:danger] = "You already vote for this recipe!"
    end
    
    redirect_to :back #because we have thumbs in index page and show page, we want the user to stay at that current page.
  
  end
  
  def destroy
    flash[:success] = " \"#{@recipe.name}\" is deleted successfully"
    Recipe.find(params[:id]).destroy
    
    redirect_to recipes_path
  end
  
  
  
  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids: []) 
      #add " array: [] " to whitelist for array in checkbox 
    end
    
    
    def comment_params
      params.require(:comment).permit(:comment)
      
    end
    
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
    
    def require_same_user
      if (@recipe.chef != current_user && !current_user.admin?) #if not recipe's user and not an admin
        flash[:danger]="You can only edit your own recipes"
        redirect_to :back #####
      end
      
      rescue ActionController::RedirectBackError
      redirect_to root_path
    end
    
    
    
end
