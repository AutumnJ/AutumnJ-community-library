class User < ActiveRecord::Base

  #include ActiveModel::Validations

  has_secure_password

  # should any validators be unique?
  # not working as needed now, commenting out

   validates :username, presence: true
  # validates :name, presence: true
  # validates :email, presence: true, format: { with: /A[^@s] @[^@s] z/ }

  has_many :books

end