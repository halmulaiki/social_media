require "sinatra/activerecord"
require "sinatra"
require "sinatra/flash"

require"./models"



configure :development do
  set :database, {adapter: "postgresql", encoding: 'unicode', database: "mediaweb"}
end

configure :production do
  set :database, {url:ENV['DATABASE_URL']}
end


enable :sessions


get '/' do

    erb :first
 end
get '/login' do
      erb :login
end
post '/login'do
 @user = User.find_by(username: params[:username])
 given_password = params[:password]
 if !@user.nil?
    if @user.password == given_password
       session[:user_id]= @user.id 
       redirect %(/profile/#{@user.lastname})
    else 
       flash[:error] = "Correct email, but wrong password. "
    end
 else
  
  flash[:error] = "Account Doesn't exists. "

   
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
  @user = User.find(session[:user_id])
  @lastname = @user.lastname
  erb :profile
    
  rescue ActiveRecord::RecordNotFound 
   puts "error 14"
   erb :feed
  end
 
get '/post'do
if (session[:user_id]==nil)

  redirect '/login'
end
@user = User.find(session[:user_id])
@lastname = @user.lastname
erb :posts
end




get '/feed'do
if (session[:user_id]==nil)

  redirect '/login'
end
@user = User.find(session[:user_id])
@posts =Post.all
@lastname = @user.lastname

erb :feed
end

post '/feed'do

@post =Post.new(title: params[:title], body: params[:body] , user_id: session[:user_id])
@post.time= Time.now.asctime
if @post.valid?
  @post.save
  @posts =Post.all
  erb :feed
else
redirect '/post'
end
end
get '/delete' do
  if (session[:user_id]==nil)
   
    redirect '/login'
  end

  given_password = params[:password]
  
  erb :delete
end
post'/delete' do
  user = User.find_by(id: session[:user_id])
  puts "asel #{user.id.class}"
  puts "asel #{session[:user_id].class}"
  puts "asel #{user.id}"

  user.destroy
  session.clear
  # erb :delete
  redirect '/'
end