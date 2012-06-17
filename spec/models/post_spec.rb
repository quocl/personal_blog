require 'spec_helper'

describe Post do
  describe "create" do
    before(:each) do
      @post = FactoryGirl.create(:post)
    end
    
    [:title, :content, :user].each do |field|
      it "should validate presence of #{field}" do
        @post.should validate_presence_of(field)
      end
    end
    
    it "should validate uniqueness of title" do
      first_post = Post.create(:title => "first_post", :content => "first_content")
      @post.should validate_uniqueness_of(:title)
    end
  end
  
  describe "destroy" do
    before(:each) do
      @comment = FactoryGirl.create(:comment)
    end
    
    after(:each) do
      @comment.destroy
    end
    
    it "should destroy all the comments associated with it" do
      Comment.all.should include(@comment)
      @comment.post.destroy
      Comment.all.should_not include(@comment)
    end
  end
end
