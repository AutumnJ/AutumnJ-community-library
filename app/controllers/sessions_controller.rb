class SessionsController < ApplicationController 

  #add signup route, that redirects to login route

  get '/login' do
    erb :'users/login'
  end

  post '/bookshelf' do
    session[:username] = params[:username]
    session[:email] = params[:email]
    puts params
  end


end