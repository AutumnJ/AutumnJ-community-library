class Book < ActiveRecord::Base

  include ActiveModel::Validations

  validates :title, presence: true 
  #title is also required field when entering book

  belongs_to :user
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :book_genres
  has_many :genres, through: :book_genres

  def slug
    title.downcase.gsub('?', "").gsub(" ","-")
    #title.downcase.gsub(/[^A-Za-z0-9\s]/i, " ").strip.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Book.all.detect {|book| book.slug == slug }
  end

  def available?
    self.status == "available"
  end 

  def borrowed?
    self.status == "borrowed"
  end

end