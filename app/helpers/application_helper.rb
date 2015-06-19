module ApplicationHelper
  def gravatar_for(chef, options = {size: 80})
    gravatar_id = Digest::MD5::hexdigest(chef.email.downcase) #this will create a MD5 code for email
    #which we will use for gravatar image
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: chef.chefname, class: "gravatar") #edit gravatar class style in custom.css.scss
  
  end
  
  
end
