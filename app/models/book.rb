class Book < ActiveRecord::Base

  belongs_to :user
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :book_genres
  has_many :genres, through: :book_genres

  def slug
    name_array = title.downcase.split(" ")
    name_array.join("-")
  end

  def self.find_by_slug(slug)
    Book.all.detect {|user| user.slug == slug }
  end

end