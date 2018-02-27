require './config/environment'
require 'sinatra/base'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  register Sinatra::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
      set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/failure' do
    erb :failure
  end


  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def current_book
      current_user.books.all.find_by_slug(params[:slug])
    end

    def found_book
      Book.find_by_slug(params[:slug])
    end

  end

end

