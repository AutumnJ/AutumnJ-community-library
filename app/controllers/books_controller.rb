class BooksController < ApplicationController 

  get '/bookshelf' do
    if logged_in?
      @user = current_user
      @books = Book.all
      erb :'/books/bookshelf'
    else
      redirect '/login'
    end
  end

  get '/bookshelf/new' do
    if logged_in?
    erb :'/books/create_book'
    else
      redirect '/login'
    end       
  end

  get '/bookshelf/:slug' do
    if logged_in?
      @book = Book.find_by_slug(params[:slug])     
      if @book.user == current_user
        erb :'/books/show_book'
      else
        redirect '/bookshelf'
      end
    else
      redirect '/login'
    end 
  end

  post '/bookshelf' do
    if !Book.find_by(title: params[:book][:title])
      @book = Book.create(params[:book])
        if !params[:genre][:name].empty?
          genre = Genre.create(name: params[:genre][:name])
          params[:genres] << genre.id
        end
        if !params[:author][:name].empty?
          author = Author.create(name: params[:author][:name])
          params[:authors] << author.id
        end

        @book.genre_ids = params[:genres]
        @book.author_ids = params[:authors]
        @book.user = current_user
        @book.save

      #redirect to '/bookshelf/#{@book.slug}' #not sure why this isn't working
      redirect to '/bookshelf'
    else #flash message 
      redirect to '/bookshelf/new'
    end
  end

  get '/bookshelf/:slug/borrow' do
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
      if @book.user != current_user && @book.status == "available"
        erb :'/books/borrow_book'
      else
        redirect '/bookshelf'
      end 
    else
      redirect '/login'
    end       
  end

  post '/bookshelf/:slug/borrow' do
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
      @book.status = "borrowed"
      @book.borrower = current_user.id
      @book.save

      redirect '/bookshelf'
    else
      redirect '/login'
    end    
  end

  get '/bookshelf/:slug/return' do
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
      if @book.borrower == current_user.id && @book.status == "borrowed"
        erb :'/books/return_book'
      else
        redirect '/bookshelf'
      end 
    else
      redirect '/login'
    end       
  end

  post '/bookshelf/:slug/return' do
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
      @book.status = "available"
      @book.borrower = nil
      @book.save

      redirect '/bookshelf'
    else
      redirect '/login'
    end    
  end

  get '/bookshelf/:slug/edit' do
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
    #create form for user to edit book info 
    #allow user to make book available for borrowing
    #add link to edit on show page
    erb :'/books/edit_book'
    else
      redirect '/login'
  end

  post '/bookshelf/:slug' do
    #make book updates 
  end

  get '/bookshelf/:slug/delete' do

  end
  #for book edit logic, (outside of borrow) if book.user_id == current_user.id
    #redirect to :bookname/edit
  #else redirect to /bookshelf

end