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

  post '/bookshelf' do #need some management for duplicate entries
    @book = Book.create(params[:book])
      if !params[:genre][:name].empty?
        @book.genres << Genre.create(name: params[:genre][:name])
      end
      if !params[:author][:name].empty?
        @book.authors << Author.create(name: params[:author][:name])
      end
      @book.genre_ids = params[:genres]
      @book.author_ids = params[:authors]
      @book.user = current_user
      @book.save

    #redirect to '/bookshelf/#{@book.slug}'
    redirect to '/bookshelf'
  end

  get '/bookshelf/:slug' do
    if logged_in?
      @book = Book.find_by_slug(params[:slug])     
      if logged_in? && @book.user == current_user
        erb :'/books/show_book'
      else
        redirect '/bookshelf'
      end
    else
      redirect '/login'
    end 
  end



  get '/bookshelf/:id/borrow' do
    #find book by id
    #verify that current user is not book owner & book is available
    #show book info
    #borrow button posts to below 
    erb :'/books/borrow_book'
  end

  post '/bookshelf/:id/borrow' do
    #updates borrower, updates status
    #redirect to main bookshelf
  end

  get '/bookshelf/:id/return' do
    #find book by id
    #verify current user id == borrower id, book status is borrowed
    #show book info
    #return button posts to below
    erb :'/books/return_book'
  end

  post '/bookshelf/:id/return' do
    #update borrower id to nil, book status to nil/available?
    #redirect to main bookshelf
  end

  get '/bookshelf/:id/edit' do
    #find book by id
    #verify that current user is owner of book
    #create form for user to edit book info 
    #allow user to make book available for borrowing
    erb :'/books/edit_book'
  end

  post '/bookshelf/:id' do
    #make book updates 
  end

  get '/bookshelf/:id/delete' do

  end
  #for book edit logic, (outside of borrow) if book.user_id == current_user.id
    #redirect to :bookname/edit
  #else redirect to /bookshelf

end