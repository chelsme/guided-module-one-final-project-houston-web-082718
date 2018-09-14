require "pry"

class CLI
    def greet_and_get_customer
        get_customer
        new_name = gets.chomp
        greet(new_name)
        Customer.find_or_create_by(name: new_name)
    end
    
    def get_customer
        puts "Welcome to Food Land! Please tell us your first and last name.".colorize(:cyan)
    end
    
    def greet(new_name)
        first_name = new_name.split(" ")[0]
        puts "Hey, #{first_name}! You can order food here.".colorize(:cyan)
    end

    def give_cuisine_choice
        puts "These are the cuisines we have available: #{FoodTruck.type_of_food.join(", ")}.".colorize(:light_green)
        puts "Which cuisine are you interested in today?".colorize(:cyan)
    end

    def customer_cuisine_choice(user_cuisine, new_customer, new_cli)
        if user_cuisine.include?("none" || "exit" || "no" || "nah")
            puts "Maybe next time!"
            exit!
        elsif user_cuisine.include?("ta")
            user_cuisine = "tacos"
        elsif user_cuisine.include?("ic") || user_cuisine.include?("cream")
            user_cuisine = "ice cream"
        elsif user_cuisine.include?("p")
            user_cuisine = "pizza"
        elsif user_cuisine.include?("d")
            user_cuisine = "donuts"
        elsif user_cuisine.include?("su") || user_cuisine.include?("rol")
            user_cuisine = "sushi"
        else
            self.run(new_customer, new_cli)
        end
        FoodTruck.where("food_type = ?", user_cuisine)
    end

    def menu?(correctmenu, new_customer)
        puts "Would you like to see the menu?".colorize(:cyan)
        input = gets.chomp.downcase
        if input.include? "y" 
            Menu.show_menu(correctmenu)
        else
            diff_cuisine(new_customer, new_cli)
        end
    end

    def diff_cuisine(new_customer, new_cli)
        puts "Would you like to choose a different cuisine?".colorize(:cyan)
        yes_or_no = gets.chomp.downcase
        if yes_or_no.include? "y"
            self.run(new_customer, new_cli)                
        else
            puts "Maybe next time!".colorize(:red)
            exit!
        end
    end

    def crud?
        puts "What would you like to do next? (choose a number)".colorize(:cyan)
        options = ["view your newest order", "change your newest order", "cancel your newest order", "place a new order from the same truck", "place a new order from a different truck", "view all of your orders", "exit"]
        options.each_with_index do |option, index|
            puts "#{index + 1}. #{option}".colorize(:light_blue)
        end
    end

    def customer_crud(new_customer, crud_choice, new_name, truckid, new_cli)
        if crud_choice == "1"
            new_customer.view_newest_order
        elsif crud_choice == "2"
            new_customer.change_newest_order
        elsif crud_choice == "3"
            new_customer.cancel_newest_order
        elsif crud_choice == "4"
            puts "What would you like to order?".colorize(:light_blue)
            new_customer.new_order(truckid, new_customer, new_cli)
        elsif crud_choice == "5"
            self.run(new_customer, new_cli)
        elsif crud_choice == "6"
            new_customer.view_all_orders(new_name)
        elsif crud_choice == "7"
            exit!
        end
        crud?
        crud_choice = gets.chomp
        customer_crud(new_customer, crud_choice, new_name, truckid, new_cli)
    end

    def run(new_customer, new_cli)
        new_name = new_customer.name
        give_cuisine_choice
        user_cuisine = gets.chomp.downcase
        selected_truck = customer_cuisine_choice(user_cuisine, new_customer, new_cli)
        truckname = FoodTruck.truck_name(selected_truck)
        truckid = FoodTruck.truck_id(selected_truck)
        correctmenu = Menu.truck_menu(truckid)
        menu?(correctmenu, new_customer)
        correctmenu = Menu.truck_menu(truckid)
        new_customer.new_order(truckid, new_customer, new_cli)
        crud?
        crud_choice = gets.chomp
        if crud_choice == "7"
            exit!
        else
            customer_crud(new_customer, crud_choice, new_name, truckid, new_cli)
        end
    end
end



