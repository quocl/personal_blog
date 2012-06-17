FactoryGirl.define do
  factory :user do |user|    
    user.email  "user@example.com"
    user.password  "password"
    user.password_confirmation  "password"
    user.username  "username"
    user.first_name "First"
    user.last_name "Last"
  end
end