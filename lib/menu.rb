class Menu < ActiveRecord::Base
    belongs_to :food_truck

    def self.truck_menu(truckid)
        truckmenu = Menu.where("food_truck_id = ?", truckid)
        truckmenu.pluck(:menu_item)
    end

    def self.show_menu(choice, correctmenu)
        if choice != "yes"
            CommandLineInterface.try_again
        end
        puts "#{correctmenu.join(", ")}"
    end
end