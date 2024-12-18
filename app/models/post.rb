class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, 300]
    attachable.variant :medium, resize_to_limit: [600, 600]
  end

  validates :title, presence: true
  validates :body, presence: true
  validates :image, content_type: ['image/png', 'image/jpeg', 'image/jpg'], 
            size: { less_than: 5.megabytes }
end
