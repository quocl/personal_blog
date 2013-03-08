require 'spec_helper'
include Warden::Test::Helpers

describe "User" do
  let!(:user){FactoryGirl.create(:user)}
  describe "sign in" do
    it "should allow user to sign in" do
      visit '/users/sign_in'

    end
  end
  
  describe "sign out" do
    it "should allow user to sign out" do
      login_as user, :scope => :user
      visit "/home" 
      page.should have_content("Welcome #{user.first_name} #{user.last_name}")
      page.should have_xpath("//a", :text => "Sign out")
      page.find(:xpath, "//a[@href='/users/sign_out']").click # The text "Sign out" is associated with destroy_user_session_path. 
                                                              # Run rake routes to find the path go with it, which is /users/sign_out     
      page.should_not have_content("Welcome #{user.first_name} #{user.last_name}")
    end
  end
  
end
