class UsersController < ApplicationController 
  
  get '/signup' do
    if session[:user_id].nil?
      erb :'users/new'
    else
      redirect to '/games'
    end
  end
  
  post '/signup' do 
   if !params["username"].empty? && !params["password"].empty?
      @user = User.create(params)
      session[:user_id] = @user.id

       redirect to '/games'
    else
      redirect to '/signup'
    end
  end

  get '/login' do 
    if logged_in?
      redirect to '/games'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user != nil && @user.authenticate(params[:password])
      session[:user_id] = @user.id

       redirect to '/games'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end 
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end
  
end 