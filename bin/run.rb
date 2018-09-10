require_relative '../config/environment'

new_cli = CommandLineInterface.new
new_cli.greet
puts "Which cuisine are you interested in today?"
user_cuisine = gets.chomp
new_cli.food_truck_offering(user_cuisine)
new_cli.menu?(user_cuisine)



