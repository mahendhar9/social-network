# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
(1..5).each do |i|
  User.create(username: "User#{i}", email: "user#{i}@mahendhar.com", password: "saibabam9", password_confirmation: "saibabam9")
p "#{i} completed"
end