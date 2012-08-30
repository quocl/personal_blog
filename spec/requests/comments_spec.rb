require 'spec_helper'

describe "Comment" do
  let!(:post){FactoryGirl.create(:post)}
  describe "create comment" do
    it "should allow people to post comment" do
      visit "/posts/#{post.id}"
      ["Name", "Email", "Body"].zip(["someone", "some@one.com", "some comment"]).each do |field, content|
        fill_in field, :with => content
      end
      click_on("Create Comment")
      current_path.should eq("/posts/#{post.title.gsub(/ /, '%20')}")
      ["someone said", "some comment"].each do |field|
        page.should have_content(field)        
      end
    end
  end
end
