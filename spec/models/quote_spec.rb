require 'spec_helper'

describe Quote do
  describe "create" do
    let!(:quote){FactoryGirl.build(:quote)}
    [:saying, :author].each do |field|
      it "should validate presence of #{field}" do
        quote.should validate_presence_of(field)
      end
    end
    
    it "should validate uniqueness of saying" do
      quote.save
      quote.should validate_uniqueness_of(:saying)
    end
  end
end
