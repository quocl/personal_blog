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
      
      it "should render show template" do
        response.should render_template("show")
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
    
    describe 'GET new' do
      it "should not be able to create an un-saved post" do
        get :new
        response.should redirect_to(user_session_path)  
      end
    end
  end
  
  describe "Login" do
    let!(:post){ FactoryGirl.create(:post)}
    before(:each) do
      sign_in post.user
    end
      
    after(:each) do
      sign_out post.user
    end
  
    describe "GET new" do
      it "should create a un-saved post" do
        expect{get :new}.to change{Post.count}.by(0)
        assigns[:post].should_not be_persisted
      end
    end
    
    describe "GET edit" do
      it "should render template edit" do
        get :edit, :id => post
        response.should render_template("edit")
      end
    end
    
    describe "DELETE destroy" do
      it "should redirect to posts_path" do
        delete :destroy, :id => post
        response.should redirect_to(posts_path)
      end
      
      it "should destroy the post" do
        expect{delete :destroy, :id => post}.to change{Post.count}.by(-1)
      end
    end
    
    describe "PUT update" do
      before(:each) do
        put :update, :id => post, :post => {:content => "new content", :title => "new_title"}
      end
      
      it "should assign to post" do
        assigns[:post].should eq(post)
      end
      
      it "should redirect to posts_path" do
        response.should redirect_to("/posts/new_title")
      end
    end
  end
end
