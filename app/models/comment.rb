class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :email, :name, :body
  validates :email, :name, :body, :presence => true
end
