class Book < ActiveRecord::Base


  #include ActiveModel::Validations
  # validates :title, presence: true 
  # not currently validating title here as it is a required field in form

  belongs_to :user
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :book_genres
  has_many :genres, through: :book_genres

  def slug
    title.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Book.all.detect {|book| book.slug == slug }
  end

end