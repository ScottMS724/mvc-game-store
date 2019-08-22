class GamesController < ApplicationController
  
  get '/games' do
    @games = Game.all 
    if logged_in?
      erb :'games/index'
    else
      redirect "/login"
    end
  end
  
  get '/games/new' do
    if logged_in?
      erb :'/games/new'
    else
      redirect "/login"
    end
  end
  
  post '/games' do
    if !params[:name].empty? && !params[:rating].empty?
      @game = Game.create(name: params[:name], rating: params[:rating])
    else
      redirect "/games/new"
    end

    if logged_in?
      @game.user_id = current_user.id
      @game.save
    end
    redirect "/games"
  end 
  
  get '/games/:id' do
    @game = Game.find(params[:id])
    if logged_in?
      erb :'/games/show'
    else
      redirect "/login"
    end
  end
  
  get "/games/:id/edit" do
    if logged_in?
      @game = Game.find(params[:id])
      if @game.user_id == current_user.id
        erb :'/games/edit'
      else
        redirect "/games"
      end
    else
      redirect "/login"
    end
  end 
  
  patch "/games/:id" do
    @game = Game.find(params[:id])
    @game.update(name: params[:name])
    @game.update(rating: params[:rating])
      if !@game.name.empty?
        redirect "/games/#{@game.id}"
      else
        redirect "/games/#{@game.id}/edit"
      end
  end 
  
  delete '/tweets/:id/delete' do
    @game = Game.find(params[:id])
      if logged_in? && @game.user_id == current_user.id
        @game.destroy
          redirect "/games"
      else
          redirect "/login"
      end
  end
  
end 