require "pry"

class CLI
    def greet_and_get_customer
        get_customer
        new_name = gets.chomp
        greet(new_name)
        Customer.create(name: new_name)
    end
    
    def get_customer
        puts "Welcome to Food Land! Please tell us your first name."
    end
    
    def greet(new_name)
        puts "Hey, #{new_name}! You can order food here."
        puts "These are the cuisines we have available: #{FoodTruck.type_of_food.join(", ")}."
    end

    def cuisine_choice
        puts "Which cuisine are you interested in today?"
    end

    def menu?(correctmenu, new_customer)
        puts "Would you like to see the menu?"
        input = gets.chomp
        if input == "yes"
            Menu.show_menu(correctmenu)
        else
            puts "Would you like to choose a different cuisine?"
            yes_or_no = gets.chomp
            if yes_or_no == "yes"
                self.run(new_customer)
            end
        end
    end

    def order?(new_customer)
        puts "Would you like to place an order from this truck?"
        input = gets.chomp
        if input == "yes"
            puts "What would you like to order?"
        else
            puts "Would you like to choose a different cuisine?"
            yes_or_no = gets.chomp
            if yes_or_no == "yes"
                self.run(new_customer)
            end
        end
    end

    def crud?
        puts "What would you like to do next? (choose a number)"
        options = ["view your order", "change your order", "cancel your order", "exit"]
        options.each_with_index do |option, index|
            puts "#{index + 1}. #{option}"
        end
    end

    def customer_crud(new_customer, crud_choice)
        if crud_choice == "1"
            new_customer.view_order
        elsif crud_choice == "2"
            new_customer.change_order
        elsif crud_choice == "3"
            new_customer.cancel_order
        end
        crud?
        crud_choice = gets.chomp
        unless crud_choice == "4"
            customer_crud(new_customer, crud_choice)
        end
    end

    def run(new_customer)
        cuisine_choice
        user_cuisine = gets.chomp
        selected_truck = FoodTruck.cuisine_choice(user_cuisine)
        truckname = FoodTruck.truck_name(selected_truck)
        truckid = FoodTruck.truck_id(selected_truck)
        correctmenu = Menu.truck_menu(truckid)
        menu?(correctmenu, new_customer)
        correctmenu = Menu.truck_menu(truckid)
        order?(new_customer)
        new_customer.new_order(truckid)
        crud?
        crud_choice = gets.chomp
        if crud_choice != "4"
            customer_crud(new_customer, crud_choice)
        end
    end
end



