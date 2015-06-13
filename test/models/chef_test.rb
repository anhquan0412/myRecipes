require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: "John", email: "whatever@yahoo.com")
  end
  
  test "email should be presence" do
     @chef.email = ""
     assert_not @chef.valid?
  end
  
  test "email must be unique" do
    chef2 = Chef.new(chefname: "whatever", email: "Whatever@yahoo.com") # or chef2 = @chef.dup, then chef2.email = @chef.email.upcase
    
    @chef.save
    assert_not chef2.valid?
  end
  
  
  test "email validation (must have @example.com tail)" do
    valid_addresses =  %w[user@eee.com R_TDD-DS@eee.hello.org user@whatever.com first.last@eem.au laura+joe@monk.cm]
    #this is just an array of email addreses
    valid_addresses.each do |address| # this is a for loop
      @chef.email = address
      assert @chef.valid?, "#{address.inspect} should be valid"
    end
  end
  
  test "reject invalid email" do
   invalid_addresses = %w[user@example,com user@org user@example. eee@i_am_.com foo@ee+aar.com]
   invalid_addresses.each do |invalid_ad|
     @chef.email = invalid_ad
     assert_not @chef.valid?, "#{invalid_ad.inspect} should be invalid"
   end
   
  end
  
    
      
 
  
end
