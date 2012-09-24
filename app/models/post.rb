class Post < ActiveRecord::Base
  extend FriendlyId 
  friendly_id :title # to display the url as post title instead of post id
  attr_accessible :content, :title, :user_id, :tag_list
  validates :content, :title, :user, :presence => true
  validates :title, :uniqueness => true
  has_many :comments, :dependent => :destroy
  belongs_to :user
	acts_as_taggable
end
