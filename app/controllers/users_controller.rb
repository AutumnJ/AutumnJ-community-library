class UsersController < ApplicationController 

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/bookshelf'
    end
  end

  post "/signup" do
    @user = User.new(name: params[:name], email: params[:email], username: params[:username], password: params[:password])
    @user.save
    redirect '/login'
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/bookshelf'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password]) #user is evaluating truthiness of line above
      session[:user_id] = @user.id
      redirect '/bookshelf'
    else
      redirect '/failure'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      erb :'users/logout'
    else
      redirect to '/'
    end
  end

end