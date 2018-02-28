class User < ActiveRecord::Base

  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}

  has_many :books

end