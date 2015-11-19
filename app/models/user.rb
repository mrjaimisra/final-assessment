class User < ActiveRecord::Base
  has_secure_password

  has_many :links
  has_many :lists

  validates :username, :password, presence: true
  validates :username, uniqueness: true
end
