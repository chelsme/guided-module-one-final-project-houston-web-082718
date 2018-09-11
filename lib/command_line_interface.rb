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

    def order?
        puts "Would you like to place an order from this truck?"
        input = gets.chomp
        if input == "yes"
            Order.new_order
        else
            puts "Would you like to choose a different cuisine?"
            new_cuisine = gets.chomp
            if new_cuisine == "yes"
                self.run
            end
        end
    end

    def new_order
        puts "What would you like to order?"
        order_item = gets.chomp
        order = Order.new
    end

    def run
        cuisine_choice
        user_cuisine = gets.chomp
        selected_truck = FoodTruck.cuisine_choice(user_cuisine)
        truckname = FoodTruck.truck_name(selected_truck)
        truckid = FoodTruck.truck_id(selected_truck)
        menu?
        choice = gets.chomp
        correctmenu = Menu.truck_menu(truckid)
        Menu.show_menu(choice, correctmenu)
        order?
    end
end



