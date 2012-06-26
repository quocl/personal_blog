require 'spec_helper'

describe PostsController do
  describe "Not login" do
    let!(:post){ FactoryGirl.create(:post)}
    describe 'GET index' do
      before(:each) do
        get :index
      end
      it "should be successful" do
        response.should be_success
      end
      
      it "should assign posts" do
        assigns[:posts].should eq(Post.all)
      end
    end
    
    describe "GET show" do
      before(:each) do
        get :show, :id => post.id
      end
      
      it "should be successful" do
        response.should be_success
      end
      
      it "should assign post to post" do
        assigns[:post].should eq(post)
      end
    end
    
    describe 'GET posts_detail' do
      before(:each) do
        get :posts_detail
      end
      
      it "should be successful" do
        response.should be_success
      end
      
      it "should assigns all posts" do
        assigns[:posts].should eq(Post.all)
      end
    end  
  end
  
  describe "Login" do
    let!(:user){FactoryGirl.create(:user)}
    before(:each) do
      
    end
    
    describe "GET new" do
      it "should create a non-saved post" do
        get :new
        
      end
    end
  end
end
