require 'spec_helper'
include Warden::Test::Helpers

describe "Posts" do
  describe "Not Sign in" do
    describe "GET /posts" do
      before(:each) do
        visit '/posts'
      end
      it "should get posts" do
        # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
        current_path.should eq('/posts')
      end    
      ["Title", "Created At"].each do |field|
        it "should show field \"#{field}\" of posts page" do
          page.should have_content(field)
        end
      end
      it "should not show \"Actions\" on posts page" do
        page.should_not have_content("Actions")  
      end
    end  
  end
  
  describe "Signed in" do
    let!(:user){FactoryGirl.create(:user)}
    before(:each) do
      login_as user, :scope => :user
    end
    after(:each) do
      logout(user)
    end
    describe "GET /posts" do
      before(:each) do
        visit '/posts'
      end
      it "should get posts" do
        current_path.should eq("/posts")
      end
      ["Title", "Created At", "Actions"].each do |field|
        it "should have content \"#{field}\"" do
            page.should have_content(field)    
        end
      end
    end
    
    describe "POST /posts" do
      it "should allow login user to create a blog post" do
        visit '/home'
        click_on("Create Post")
        page.should have_content("New Post")
        current_path.should eq("/posts/new")
        fill_in "Title", :with => "Title"
        fill_in "Content", :with => "content"
        click_button "Create Post"
        current_path.should eq("/posts/#{Post.last.id}")
      end
    end
  end
end
