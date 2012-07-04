class Quote < ActiveRecord::Base
  attr_accessible :author, :saying
  validates :author, :saying, :presence => true
  validates :saying, :uniqueness => true
end
