class User < ActiveRecord::Base
  has_secure_password
  has_many :airports
  has_many :reviews, through: :airports
end
