class User < ActiveRecord::Base

  include ActiveModel::Validations

  has_secure_password

  validates :username, presence: true
  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}

  has_many :books

end