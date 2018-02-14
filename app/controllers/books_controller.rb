class BooksController < ApplicationController 

    #put logic below in it's own controller? (add that controller to config.ru)

  get '/bookshelf' do
    # add if !logged_in? logic 
      # redict to '/login'
    # session[:username] = params[:username]
    # session[:email] = params[:email]
    # puts params
    erb :'/books/bookshelf'
  end

  get '/bookshelf/:id' do
    #find book by id
    #in view, display specific book details -- create books/show_book
    #link to edit and delete
  end

  get '/bookshelf/:id/borrow' do
    #find book by id
    #verify that current user is not book owner & book is available
    #show book info
    #borrow button 
    #create post route that updates borrower and redirects 
  end

  get '/bookshelf/:id/return' do

  end

  get '/bookshelf/:id/edit' do
    #find book by id
    #verify that current user is owner of book
    #create form for user to edit book info 
    #allow uer to make book available for borrowing

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