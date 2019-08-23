class UsersController < ApplicationController 
  
  get '/signup' do
    if !logged_in?
      erb :'users/new'
    else
      redirect '/games'
    end
  end
  
  post '/signup' do 
    @user = User.new(username: params["username"], password: params["password"])

    if @user.save && !@user.username.empty?
      @user.save
      session[:user_id] = @user.id
      redirect "/games"
    else
      redirect "/signup"
    end
  end

  get '/login' do 
    if !logged_in?
      erb :'users/login'
    else
      redirect '/games'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/games"
    else
      redirect "/login?error=Invalid name or password."
    end
  end

  get '/logout' do
    session.clear 
    redirect '/login'
  end 
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @games =  @user.games 
    erb :'/users/show'
  end
  
end 