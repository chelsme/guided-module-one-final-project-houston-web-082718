class CommandLineInterface
    def greet
        puts "Welcome to Food Land! You can order food here. These are the cuisines we have available: #{FoodTruck.type_of_food.join(", ")}."
    end

    def cuisine_choice
        puts "Which cuisine are you interested in today?"
    end

    # def menu?(user_cuisine)
    #     puts "Would you like to see the menu?"
    #     choice = gets.chomp
    #     if choice == "yes"
    #         puts "heck yes!"
    #     else
    #         puts "Which cuisine are you interested in today?"
    #         user_cuisine = gets.chomp
    #         food_truck_offering(user_cuisine)
    #     end
    # end

    def run
        greet
        cuisine_choice
        user_cuisine = gets.chomp
        selected_truck = FoodTruck.cuisine_choice(user_cuisine)
        truckname = FoodTruck.truck_name(selected_truck)
        truckid = FoodTruck.truck_id(selected_truck)
        Menu.truck_menu(truckid)
    end
end



