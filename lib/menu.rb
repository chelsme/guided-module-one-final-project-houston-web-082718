class Menu < ActiveRecord::Base
    belongs_to :food_truck

    def self.truck_menu(truckid)
        truckmenu = Menu.where("food_truck_id = ?", truckid)
        truckmenu.pluck(:menu_item)
    end
end