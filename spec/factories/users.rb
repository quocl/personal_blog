FactoryGirl.define do
  factory :user do |user|    
    user.email  "user@example.com"
    user.password  "password"
    user.password_confirmation  "password"
    user.username  "username"
  end
end