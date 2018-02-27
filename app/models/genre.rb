class Genre < ActiveRecord::Base

  include ActiveModel::Validations

  has_many :book_genres
  has_many :books, through: :book_genres
  has_many :authors, through: :books

  validates_uniqueness_of :name

end