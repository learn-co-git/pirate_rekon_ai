# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(:name => "Burt", :email => "burt@sesamestreet.com", :password_digest => "", :created_at => 2020-07-06, :updated_at => 2020_07_06_054654)

user2 = User.create(:name => "Ernie", :email => "ernie@sesamestreet.com", :password_digest => "", :created_at => 2019-07-06, :updated_at => 2019_07_06_054654)

vehicle1 = Vehicle.create(:vehicle_id => 100, :make => "toyota", :model => "truck", :year => 1980, :plate => "AKELE191", :color => "black", :background => "", :url => "https://res.cloudinary.com/argustwo/image/upload/v1594095774/yaneynpz4cl4ytq4tc9o.jpg", :user_id_id => 3)

vehicle2 = Vehicle.create(:vehicle_id => 100, :make => "ford", :model => "f150", :year => 1989, :plate => "CAELE191", :color => "blue", :background => "", url: => "https://res.cloudinary.com/argustwo/image/upload/v1594095755/npewx2lu8hzljhamj67k.jpg", :user_id_id => 4)
