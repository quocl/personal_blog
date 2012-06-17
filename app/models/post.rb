class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id
  validates :content, :title, :presence => true
  validates :title, :uniqueness => true
  has_many :comments, :dependent => :destroy
  belongs_to :user
end
