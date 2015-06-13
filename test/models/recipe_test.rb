require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create(chefname: "Bob", email: "bob@something.com")
    @recipe = @chef.recipes.build(name: "Chicken Parm", summary: "This is the best recipe ever",
      description: "Bla bla bla heat oils eat chicken bla bla bla")
    #if we just use recipe, recipe is a local variable and cannt not be used for other functions in here
    #the @chef created in test file are in database as well but in sand-box mode, meaning it will be roll-back
    # (delete from database) after the test is done.
    
    
    
  end
  
  test  "recipe should be valid" do
    assert @recipe.valid? #if @recipe.valid? returns true, pass the test
  end
  
  test "chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid? # if @recipe.valid? returns false, pass the test
  end
  
  test "name length violation" do
    @recipe.name = "a" * 101
    assert_not @recipe.valid? 
    
    @recipe.name = "aaa"
    assert_not @recipe.valid?
  end
  
  test "summary should be present" do
  end
  
  test "summary length violation" do
  end
  

end
