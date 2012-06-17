require 'spec_helper'

describe User do
  describe '#create' do
    let!(:user){ FactoryGirl.create(:user) }
    [:username, :email].each do |field|
      it "should validate uniqueness of #{field}" do
         user.should validate_uniqueness_of(field)
      end      
    end
  end
end
