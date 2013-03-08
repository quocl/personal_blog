# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

quotes =[["Chance favors the prepared mind.", "Louis Pasteur"],
         ["We can only see a short distance ahead, but we can see plenty there that needs to be done.", "Alan Turing"],
         ["Genius is one percent inspiration, ninety-nine percent perspiration.", "Thomas Edison"],
         ["Many of life's failures are people who did not realize how close they were to success when they gave up.", "Thomas Edison"],
         ["How often have I said to you that when you have eliminated the impossible, whatever remains, however improbable, must be the truth?", "Arthur Conan Doyle"],
         ["Nothing in life is to be feared, it is only to be understood.", "Marie Curie"],
         ["I never guess. It is a shocking habit, destructive to the logical faculty.", "Arthur Conan Doyle"],
         ["Life is like riding a bicycle. To keep your balance you must keep moving.", "Albert Einstein"]]
         
quotes.each do |quote|
  Quote.find_or_create_by_saying(:saying => quote[0], :author => quote[1])
end
if User.count < 1
  u = User.new(:username => 'username', :first_name => "First", :last_name => "Last", :email => "user@example.com", :password => "password", :password_confirmation => "password")
  u.save!
end