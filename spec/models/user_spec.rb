require 'spec_helper'

describe User do
  describe "create" do
    let!(:user){ FactoryGirl.create(:user) }
    [:username, :email].each do |field|
      it "should validate uniqueness of #{field}" do
         user.should validate_uniqueness_of(field)
      end      
    end
    
    [:username, :email, :password].each do |field|
      it "should validate presence of #{field}" do
        user.should validate_presence_of(field)
      end
      
    end
  end
  
  describe "destroy" do
    let!(:post){ FactoryGirl.create(:post)}
    it "should destroy all post belong to the user when user is destroyed" do
      Post.all.should include(post)
      post.user.destroy
      Post.all.should_not include(post)
    end
  end
end
