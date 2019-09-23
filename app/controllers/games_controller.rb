class GamesController < ApplicationController
  
  get '/games' do
      redirect_if_not_logged_in
      @games = Game.all
      @user = User.find(session[:user_id])
      erb :'/games/index' 
  end
  
  get '/games/new' do
    redirect_if_not_logged_in
    erb :'/games/new'
  end
  
  post '/games/new' do
    if params[:name] != ""  
      game = Game.create(params)
      game.user_id = session[:user_id]
      game.save

      redirect to '/games'
    else
      redirect to '/games/new'
    end
  end
  
  get '/games/:id' do
    redirect_if_not_logged_in
    @game = Game.find_by_id(params[:id])
    if !@game || @game.user != current_user
      redirect to '/games'
    else 
      erb :'/games/show'
    end 
  end
  
  get '/games/:id/edit' do
    redirect_if_not_logged_in
    @game = Game.find_by_id(params[:id])
    if !@game || @game.user != current_user 
      redirect to '/login'
    else 
      erb :'/games/edit'
    end 
  end
  
  patch '/games/:id' do
    redirect_if_not_logged_in
    if params[:name] == ""
      redirect to "/games/#{params[:id]}/edit"
    else
      @game = Game.find(params[:id])

        if @game.user == current_user

           if @game.name != params[:name] || @game.rating != params[:rating]
            @game.name = params[:name]
            @game.rating = params[:rating]
            @game.save

             redirect to "/games/#{@game.id}"
          else
            redirect to "/games/#{@game.id}/edit"
          end
        else

           redirect to '/games'
        end
      end
  end
  
  delete '/games/:id/delete' do
    redirect_if_not_logged_in
    @game = Game.find(params[:id])
    if @game.user == current_user
      @game.delete
    end
    redirect to '/games'
  end
  
end 