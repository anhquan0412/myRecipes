if Rails.env.production? #define in picture_uploader.rb?
#need this to handle picture upload in production and manage credential when communicating with AWS
  CarrierWave.configure do |config|
   config.fog_credentials = {
     :provider => 'AWS',
     :aws_access_key_id => ENV['S3_ACCESS_KEY'], #ENV is heroku variable to help us avoid hard-coding sensitive information
     #such as access key or secret key
     :aws_secret_access_key => ENV['S3_SECRET_KEY'],
   } 
   
   
   config.fog_directory = ENV['S3_BUCKET']
  end
  
end