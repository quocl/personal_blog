require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "title cannot be blank" do
    post = Post.new(:content=>"abc")
    assert(post.title == nil, "assert title is blank")
    assert(!post.save, "assert post cannot be saved")
  end
  
  test "content cannot be blank" do
    post = Post.new(:title=>"abc")
    assert(post.content == nil, "assert title is blank")
    assert(!post.save, "assert post cannot be saved")
  end
  
end
