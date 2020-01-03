require "sinatra/activerecord"
require "sinatra"
require "sinatra/flash"

require"./models"
set :port , 3000
set :database, {adapter: "sqlite3", database: "data.sqlite3"}

enable :sessions


# get '/' do
#     erb:home
# end
get '/login' do
      erb :login
end
post '/login'do
 @user = User.find_by(email: params[:email])
 given_password = params[:password]
 if @user.password == given_password
    session[:user_id]= @user.id 
    redirect %(/profile/#{@user.id})
    else 
    flash[:error] = "Correct email, but wrong password. Did you mean: #{user.password}
    only "
 
  end 

end
get '/logout'do
 session.clear
 redirect '/login'
end
post '/logout' do 
  session.clear
  p "User Logged out Successfully"
  redirect '/login'
end 
get '/' do
    erb :signup
  end
post '/' do
  puts params
  @user =User.new(params[:user])
  puts @user
  if @user.valid?
     @user.save
     puts @user.id
     puts 'REDIRECT NOW!!!'
    redirect %(/profile/#{@user.id})
  else
    flash[:error] = @user.errors.full_messages
    redirect '/'
  end
  p para
end
get '/profile/:id' do
  @user = User.find(params[:id])
    #redirect '/' unless session[:user_id]
    erb :profile
rescue ActiveRecord::RecordNotFound
  puts "erroe14"
  erb :home

  #end
end