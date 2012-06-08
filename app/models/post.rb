class Post < ActiveRecord::Base
  attr_accessible :content, :title
  validates :title,  :presence => true
  validates :content, :presence => true
  validates :title, :uniqueness => true
  has_many :comments, :dependent => :destroy
end
