require 'sinatra/base'
require 'sinatra/flash'

class BooksController < ApplicationController 

  register Sinatra::Flash

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
      if @book = current_user.books.all.find_by_slug(params[:slug])     
        erb :'/books/show_book'
      else
        redirect '/bookshelf' #flash message - looks like that's not one of your books
      end
    else
      redirect '/login'
    end 
  end

  post '/bookshelf' do
    if !current_user.books.all.find_by(title: params[:book][:title])
      @book = Book.create(params[:book])
        if !params[:genre][:name].empty? && !Genre.find_by(name: params[:genre][:name]) #needs work to prevent duplicate genres
          genre = Genre.create(name: params[:genre][:name])
          if params[:genres].nil?
            params[:genres] = []
          end
          params[:genres] << genre.id
        end
        if !params[:author][:name].empty? && Author.find_by(name: params[:author][:name]) #needs work to prevent duplicate authors
          author = Author.create(name: params[:author][:name])
          if params[:authors].nil?
            params[:authors] = []
          end
            params[:authors] << author.id
        end

        @book.genre_ids = params[:genres]
        @book.author_ids = params[:authors]
        @book.user = current_user
        @book.save

        flash[:message] = "Successfully created book."
        redirect to "/bookshelf/#{@book.slug}"
    else 
      flash[:message] = "A book with that title is already in your collection."
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
      if @book = current_user.books.all.find_by_slug(params[:slug])
          erb :'/books/edit_book'
      else
        redirect '/bookshelf'
      end
    else
      redirect '/login'
    end
  end

  patch '/bookshelf/:slug' do #add logic to prevent duplicate authors/genres?
    if logged_in?
      @book = current_user.books.all.find_by_slug(params[:slug])
      @book.update(params[:book])
        if !params[:genre][:name].empty?
          genre = Genre.create(name: params[:genre][:name])
          @book.genres << genre
        end
        if !params[:author][:name].empty?
          author = Author.create(name: params[:author][:name])
          @book.authors << author
        end
        @book.save

        flash[:message] = "Successfully updated book."
        redirect to "/bookshelf/#{@book.slug}"
    else
      redirect '/login'
    end
  end

  delete '/bookshelf/:slug/delete' do
    if logged_in?
      if @book = current_user.books.all.find_by_slug(params[:slug])
        @book.delete

        flash[:message] = "The book was removed from your library."
        redirect '/bookshelf'
      end  
    else
      redirect '/login'
    end
  end

end