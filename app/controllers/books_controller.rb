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
    #send post request to below
    erb :'/books/create_book'
  end

  post '/bookshelf' do
    #create book, create author, create genre as needed 
    #redirect to bookshelf
  end

  get '/bookshelf/:slug' do
    if logged_in?
      @book = Book.find_by_slug(params[:slug])     
      # if @book.user == current_user
        erb :'/books/show_book'
      # else
      #   redirect '/bookshelf'
      # end
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