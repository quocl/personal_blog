class Post < ActiveRecord::Base
  extend FriendlyId 
  friendly_id :title, use: :slugged # to display the url as post title instead of post id
  attr_accessible :content, :title, :user_id
  validates :content, :title, :user, :presence => true
  validates :title, :uniqueness => true
  has_many :comments, :dependent => :destroy
  belongs_to :user
end
