class SessionsController < ApplicationController 

  #add signup route, that redirects to login route

  get '/signup' do
    erb :'users/signup'
  end

  post "/signup" do
    user = User.new(name: params[:name], email: params[:email], username: params[:username], password: params[:password])

    if user.save && user.username != "" 
      redirect '/login'
    else
      redirect '/failure'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/bookshelf'
    else
      redirect '/failure'
    end
  end

  get '/logout' do
    session.clear
    erb :'users/logout'
  end

  #put logic below in it's own controller? (add that controller to config.ru)

  post '/bookshelf' do
    # add if !logged_in? logic 
      # redict to '/login'
    session[:username] = params[:username]
    session[:email] = params[:email]
    puts params
  end


end