require 'sinatra/base'
require 'sinatra/flash'

class UsersController < ApplicationController  

  register Sinatra::Flash

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      flash[:message] = "You're already logged in!"
      redirect to '/bookshelf'
    end
  end

  post "/signup" do
    @user = User.new(name: params[:name], email: params[:email], username: params[:username], password: params[:password])
    if @user.valid?
      @user.save
      redirect '/login'
      else 
      flash[:message] = "Please enter your name, a valid email address, and a username and password for future logins."
      redirect '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      flash[:message] = "You're already logged in!"
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
      session.destroy
      erb :'users/logout'
    else
      redirect to '/'
    end
  end

end