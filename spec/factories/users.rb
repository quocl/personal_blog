FactoryGirl.define do
  factory :user do |user|    
    user.email  "rspec@example.com"
    user.password  "password"
    user.password_confirmation  "password"
    user.username  "rspec_username"
    user.first_name "First"
    user.last_name "Last"
  end
end