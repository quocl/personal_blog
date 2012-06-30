require 'spec_helper'
include Warden::Test::Helpers

describe "User" do
  let!(:user){FactoryGirl.create(:user)}
  describe "sign in" do
    it "should allow user to sign in" do
      visit '/users/sign_in'
      ["Email", "Password", "Sign in"].each do |content|
        page.should have_content(content)
      end
      page.should_not have_content("Welcome")
      ["Email", "Password"].zip([user.email, user.password]).each do |field, credential|
        fill_in field, :with => credential
      end
      click_button "Sign in"
      page.should have_content("Welcome #{user.first_name} #{user.last_name}")
    end
  end
  
  describe "sign out" do
    it "should let user to sign out" do
      login_as user, :scope => :user
      visit "/home" 
      page.should have_content("Welcome #{user.first_name} #{user.last_name}")
      page.should have_xpath("//a", :text => "Sign out")
      page.find(:xpath, "//a[@href='/users/sign_out']").click
      page.should_not have_content("Welcome #{user.first_name} #{user.last_name}")
    end
  end
  
end
