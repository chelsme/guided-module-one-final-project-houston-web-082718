require "pry"

class CLI
    def greet_and_get_customer
        get_customer
        new_name = gets.chomp
        greet(new_name)
        Customer.find_or_create_by(name: new_name)
    end
    
    def get_customer
        puts "Welcome to Food Land! Please tell us your first and last name."
    end
    
    def greet(new_name)
        first_name = new_name.split(" ")[0]
        puts "Hey, #{first_name}! You can order food here."
    end

    def give_cuisine_choice
        puts "These are the cuisines we have available: #{FoodTruck.type_of_food.join(", ")}."
        puts "Which cuisine are you interested in today?"
    end

    def customer_cuisine_choice(user_cuisine, new_customer)
        if user_cuisine.include?("none" || "exit" || "no" || "nah")
            puts "Maybe next time!"
            exit!
        elsif user_cuisine.include?("ta")
            user_cuisine = "tacos"
        elsif user_cuisine.include?("ice" || "cream" || "ic")
            user_cuisine = "ice cream"
        elsif user_cuisine.include?("pi")
            user_cuisine = "pizza"
        elsif user_cuisine.include?("do")
            user_cuisine = "donuts"
        elsif user_cuisine.include?("su" || "roll")
            user_cuisine = "sushi"
        else
            self.run(new_customer)
        end
        FoodTruck.where("food_type = ?", user_cuisine)
    end

    def menu?(correctmenu, new_customer)
        puts "Would you like to see the menu?"
        input = gets.chomp
        if input.include? "y" 
            Menu.show_menu(correctmenu)
        else
            puts "Would you like to choose a different cuisine?"
            yes_or_no = gets.chomp
            if yes_or_no.include? "y"
                self.run(new_customer)
            else
                puts "Maybe next time!"
                exit!
            end
        end
    end

    def order?(new_customer)
        puts "Would you like to place an order from this truck?"
        input = gets.chomp
        if input.include? "y"
            puts "What would you like to order?"
        else
            puts "Would you like to choose a different cuisine?"
            yes_or_no = gets.chomp
            if yes_or_no.include? "y"
                self.run(new_customer)                
            else
                puts "Maybe next time!"
                exit!
            end
        end
    end

    def crud?
        puts "What would you like to do next? (choose a number)"
        options = ["view your newest order", "change your newest order", "cancel your newest order", "view all of your orders", "exit"]
        options.each_with_index do |option, index|
            puts "#{index + 1}. #{option}"
        end
    end

    def customer_crud(new_customer, crud_choice, new_name)
        if crud_choice == "1"
            new_customer.view_newest_order
        elsif crud_choice == "2"
            new_customer.change_newest_order
        elsif crud_choice == "3"
            new_customer.cancel_newest_order
        elsif crud_choice == "4"
            new_customer.view_all_orders(new_name)
        elsif crud_choice == "5"
            exit!
        end
        crud?
        crud_choice = gets.chomp
        customer_crud(new_customer, crud_choice, new_name)
    end

    def run(new_customer)
        new_name = new_customer.name
        give_cuisine_choice
        user_cuisine = gets.chomp
        selected_truck = customer_cuisine_choice(user_cuisine, new_customer)
        truckname = FoodTruck.truck_name(selected_truck)
        truckid = FoodTruck.truck_id(selected_truck)
        correctmenu = Menu.truck_menu(truckid)
        menu?(correctmenu, new_customer)
        correctmenu = Menu.truck_menu(truckid)
        order?(new_customer)
        new_customer.new_order(truckid)
        crud?
        crud_choice = gets.chomp
        if crud_choice == "5"
            exit!
        else
            customer_crud(new_customer, crud_choice, new_name)
        end
    end
end



