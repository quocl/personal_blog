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
      ["Title", "Posted on"].each do |field|
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
      ["Title", "Posted on", "Actions"].each do |field|
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
        current_path.should eq("/posts/#{Post.last.title.gsub(/ /, '%20')}")
      end
    end
    
    describe "modify post" do
      let!(:post){FactoryGirl.create(:post, :user => user)}
      describe "GET edit" do
        it "should allow user to edit his own post" do
          visit "/posts/#{post.title.gsub(/ /, '%20')}"
          click_link("Edit Post")
          current_path.should eq("/posts/#{post.title.gsub(/ /, '%20')}/edit")
        end
        
        it "should not let a user edit a post that is not his" do
          user2 = FactoryGirl.create(:user, :username => "other", :email => "other@other.com")
          post2 = FactoryGirl.create(:post, :title => "Some other", :user => user2)
          visit "/posts/#{post2.id}"
          page.should_not have_content("Edit Post")
        end
      end
      
      describe "PUT update" do
        it "should allow user to save change to his own post" do
          visit "/posts/#{post.title.gsub(/ /, '%20')}/edit"
          current_path.should eq("/posts/#{post.title.gsub(/ /, '%20')}/edit")
          fill_in("Title", :with => "newTitle")
          fill_in("Content", :with => "Some content")
          click_on "Update Post"
          puts current_path
        end      
      end
      
      describe "DESTROY delete" do
        it "should let owner destroy his post" do
          visit "/posts/#{post.id}"
          expect{click_on("Delete Post")}.to change{Post.count}.by(-1)
        end
        
        it "should not let user to destroy post that is not his" do
          other_user = FactoryGirl.create(:user, :email => "other@other.com", :username => "other")
          other_post = FactoryGirl.create(:post, :title => "other title", :user => other_user)
          visit "/posts/#{other_post.id}"
          page.should_not have_content("Delete Post")
        end
      end
      
      describe "GET/ show" do
        it "should show the title of the post in the url" do
          visit "/posts/#{post.title.gsub(/ /, '%20')}"
          current_path.should eq("/posts/#{post.title.gsub(/ /, '%20')}")
        end
      end
    end
  end
end
