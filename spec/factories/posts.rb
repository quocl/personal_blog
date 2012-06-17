FactoryGirl.define do
  factory :post do |post|    
    post.title "post_title"
    post.content  "post_content"
    post.association :user
  end
end