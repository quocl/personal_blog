FactoryGirl.define do 
  factory :comment do |comment|
    comment.name "comment_author"
    comment.email "someone@example.com"
    comment.body "comment_body"
    comment.association :post
  end 
end   