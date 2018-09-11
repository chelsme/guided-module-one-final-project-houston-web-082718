class Menu < ActiveRecord::Base
    belongs_to :food_truck

    def self.truck_menu(truckid)
        truckmenu = Menu.where("food_truck_id = ?", truckid)
        truckmenu.pluck(:menu_item)
    end

    def self.show_menu(choice, correctmenu)
        while choice != "yes"
            puts "Which cuisine are you interested in today?"
            user_cuisine = gets.chomp
            selected_truck = FoodTruck.cuisine_choice(user_cuisine)
            truckname = FoodTruck.truck_name(selected_truck)
            truckid = FoodTruck.truck_id(selected_truck)
            puts "Would you like to see the menu?"
            choice = gets.chomp
        end
        puts "#{correctmenu.join(", ")}"
    end

end