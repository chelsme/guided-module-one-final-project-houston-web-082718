class CommandLineInterface
    def greet
        puts "Welcome to Food Land! You can order food here. These are the cuisines we have available: #{FoodTruck.type_of_food.join(", ")}."
    end

    def food_truck_offering(user_cuisine)
        foodtruckchoice = FoodTruck.all.select do |truck|
            truck.food_type == user_cuisine
        end
        mytruck = foodtruckchoice.map do |truck|
            truck.name
        end
        puts "Great choice! #{mytruck.join("")} is the food truck for you."
    end

    def menu?(user_cuisine)
        puts "Would you like to see the menu?"
        choice = gets.chomp
        if choice == "yes"
            puts "heck yes!"
        else
            puts "Which cuisine are you interested in today?"
            user_cuisine = gets.chomp
            food_truck_offering(user_cuisine)
        end
    end
end



