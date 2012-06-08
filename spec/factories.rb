FactoryGirl.define do
  factory :post do |post|    
    post.title "post_title"
    post.content  "post_content"
  end
  
  factory :comment do |comment|
    comment.name "comment_author"
    comment.email "someone@example.com"
    comment.body "comment_body"
    comment.association :post
  end 
end   




