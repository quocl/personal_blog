require "spec_helper"

describe "Comment" do
  describe 'create' do
    before(:each) do
      @comment = Comment.new
    end
    
    [:email, :name, :body].each do |field|
      it "should validate presence of #{field}" do
        @comment.should validate_presence_of(field)
      end
    end
        
    it "should belong to post" do
      @comment.should belong_to(:post)
    end
  end
end
