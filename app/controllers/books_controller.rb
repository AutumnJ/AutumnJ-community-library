require 'sinatra/base'
require 'sinatra/flash'

class BooksController < ApplicationController 

  register Sinatra::Flash

  get '/bookshelf' do
    if logged_in?
      @user = current_user
      @books = Book.order(:title).all
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
      if @book = current_book     
        erb :'/books/show_book'
      else
        flash[:message] = "Oops, that's not a book in your collection."
        redirect '/bookshelf'
      end
    else
      redirect '/login'
    end 
  end

  post '/bookshelf' do
    if !current_user.books.all.find_by(title: params[:book][:title])
      @book = Book.create(params[:book])
        if !params[:genre][:name].empty?
          genre = Genre.find_or_create_by(name: params[:genre][:name].titleize)
          if params[:genres].nil?
            params[:genres] = []
          end
          if !params[:genres].include?(genre.id.to_s)
            params[:genres] << genre.id
          end
        end
        if !params[:author][:name].empty?
          author = Author.find_or_create_by(name: params[:author][:name].titleize)
          if params[:authors].nil?
            params[:authors] = []
          end
          if !params[:authors].include?(author.id.to_s)
            params[:authors] << author.id
          end
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
      @book = found_book
      if @book.user != current_user && Book.available?(@book)
        erb :'/books/borrow_book'
      else
        flash[:message] = "Please choose a book that's available for borrowing."
        redirect '/bookshelf'
      end 
    else
      redirect '/login'
    end       
  end

  post '/bookshelf/:slug/borrow' do
    if logged_in?
      @book = found_book
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
      @book = found_book
      if @book.borrower == current_user.id && Book.borrowed?(@book)
        erb :'/books/return_book'
      else
        flash[:message] = "You're only able to return books that you are currently borrowing."
        redirect '/bookshelf'
      end 
    else
      redirect '/login'
    end       
  end

  post '/bookshelf/:slug/return' do
    if logged_in?
      @book = found_book
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
      if @book = current_book
          erb :'/books/edit_book'
      else
        flash[:message] = "You're only able to edit books that are part of your collection."
        redirect '/bookshelf'
      end
    else
      redirect '/login'
    end
  end

  patch '/bookshelf/:slug' do
    if logged_in?
      @book = current_book
      @book.update(params[:book])
        if !params[:genre][:name].empty?
          genre = Genre.find_or_create_by(name: params[:genre][:name].titleize)
          if !@book.genres.include?(genre) 
            @book.genres << genre
          end
        end
        if !params[:author][:name].empty?
          author = Author.find_or_create_by(name: params[:author][:name].titleize)
          if !@book.authors.include?(author) 
            @book.authors << author
          end  
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
      if @book = current_book
        @book.delete

        flash[:message] = "The book was removed from your library."
        redirect '/bookshelf'
      end  
    else
      redirect '/login'
    end
  end

  private 

  def current_book
    current_user.books.all.find_by_slug(params[:slug])
  end

  def found_book
    Book.find_by_slug(params[:slug])
  end

end