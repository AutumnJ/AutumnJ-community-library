class UsersController < ApplicationController 

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/bookshelf'
    end
  end

  post "/signup" do
    if params[:name] = "" || params[:email] == "" || params[:username] == "" || params[:password] == ""
      redirect to '/failure'
    else
      @user = User.new(name: params[:name], email: params[:email], username: params[:username], password: params[:password])
      @user.save
      redirect '/login'
    end
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

  #put logic below in it's own controller? (add that controller to config.ru)

  post '/bookshelf' do
    # add if !logged_in? logic 
      # redict to '/login'
    session[:username] = params[:username]
    session[:email] = params[:email]
    puts params
  end

  #for book edit logic, (outside of borrow) if book.user_id == current_user.id
    #redirect to :bookname/edit
  #else redirect to /bookshelf

end