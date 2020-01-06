require "sinatra/activerecord"
require "sinatra"
require "sinatra/flash"

require"./models"
set :port , 3000
set :database, {adapter: "postgresql", encoding: 'unicode', database: "mediaweb"}

enable :sessions


# get '/' do
#     erb:home
# end
get '/login' do
      erb :login
end
post '/login'do
 @user = User.find_by(username: params[:username])
 given_password = params[:password]
 if @user.password == given_password
    session[:user_id]= @user.id 
    redirect %(/profile/#{@user.lastname})
    else 
    flash[:error] = "Correct email, but wrong password. "
 
  end 

end
get '/logout'do
 session.clear
 redirect '/login'
end
# post '/logout' do 
#   #session[:user_id] = nil
#   session.clear
#   p "User Logged out Successfully"
#   redirect '/login'
# end 
get '/signup' do
    erb :signup
  end
post '/signup' do
  puts params
  @user =User.new(params[:user])
  puts @user
  if @user.valid?
     @user.save
     puts @user.id
     puts 'REDIRECT NOW!!!'
    redirect %(/profile/#{@user.lastname})
  else
    flash[:error] = @user.errors.full_messages
    redirect '/login'
  end
  p para
end
get '/profile/:lastname' do
  if (session[:user_id]==nil)
    redirect '/login'
  end
  @user = User.find(params[:username])
   
  erb :profile
    
  rescue ActiveRecord::RecordNotFound 
   puts "error 14"
   erb :feed
  end
 
get '/feed'do
if (session[:user_id]==nil)
  redirect '/login'
 erb :feed
end
end