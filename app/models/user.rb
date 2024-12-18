class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  enum role: [:user, :admin]

  has_many :posts
  has_many :comments
  has_many :likes

    validates :username, 
    presence: true, 
    uniqueness: { case_sensitive: false }, 
    length: { minimum: 3, maximum: 25 },
    format: { with: /\A[a-zA-Z0-9_]+\z/, message: "can only contain letters, numbers, and underscores" }
end
