require "pry"

class CommandLineInterface
    def greet
        puts "Welcome to Food Land! You can order food here. These are the cuisines we have available: #{FoodTruck.type_of_food.join(", ")}."
    end

    def cuisine_choice
        puts "Which cuisine are you interested in today?"
    end

    def menu?
        puts "Would you like to see the menu?"
    end

    def self.try_again
            puts "Which cuisine are you interested in today?"
            user_cuisine = gets.chomp
            selected_truck = FoodTruck.cuisine_choice(user_cuisine)
            truckname = FoodTruck.truck_name(selected_truck)
            truckid = FoodTruck.truck_id(selected_truck)
            puts "Would you like to see the menu?"
            choice = gets.chomp
            correctmenu = Menu.truck_menu(truckid)
            Menu.show_menu(choice, correctmenu)
    end

    def run
        greet
        cuisine_choice
        user_cuisine = gets.chomp
        selected_truck = FoodTruck.cuisine_choice(user_cuisine)
        truckname = FoodTruck.truck_name(selected_truck)
        truckid = FoodTruck.truck_id(selected_truck)
        menu?
        choice = gets.chomp
        correctmenu = Menu.truck_menu(truckid)
        Menu.show_menu(choice, correctmenu)
        
        # binding.pry
    end
end



