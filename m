
[1mFrom:[0m /home/ubuntu/workspace/app/controllers/recipes_controller.rb @ line 53 RecipesController#like:

    [1;34m52[0m: [32mdef[0m [1;34mlike[0m
 => [1;34m53[0m:   binding.pry
    [1;34m54[0m:   temp = params[[33m:like[0m]
    [1;34m55[0m:   @recipe = [1;34;4mRecipe[0m.find(params[[33m:id[0m])
    [1;34m56[0m:   [1;34;4mLike[0m.create([35mlike[0m: params[[33m:like[0m], [35mchef[0m: [1;34;4mChef[0m.first, [35mrecipe[0m: @recipe)
    [1;34m57[0m: 
    [1;34m58[0m:   [1;34m#params[:like] would return true if thumb-up, false if thumb-down, this is passed here from show.html.erb[0m
    [1;34m59[0m:   [32mif[0m temp == [1;34m1[0m
    [1;34m60[0m:     flash[[33m:success[0m] = [31m[1;31m"[0m[31mYou liked this recipe![1;31m"[0m[31m[0m
    [1;34m61[0m:   [32melse[0m
    [1;34m62[0m:     flash[[33m:success[0m] = [31m[1;31m"[0m[31mYou disliked this recipe![1;31m"[0m[31m[0m
    [1;34m63[0m:   [32mend[0m
    [1;34m64[0m:   redirect_to [33m:back[0m [1;34m#because we have thumbs in index page and show page, we want the user to stay at that current page.[0m
    [1;34m65[0m: 
    [1;34m66[0m: [32mend[0m

