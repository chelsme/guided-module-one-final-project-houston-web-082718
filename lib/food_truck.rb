class FoodTruck < ActiveRecord::Base
    has_many :orders
    has_many :customers, through: :orders

    def self.type_of_food
        self.pluck(:food_type)
    end

    def self.cuisine_choice(user_cuisine)
        self.where("food_type = ?", user_cuisine)
    end
    
    def self.truck_name(selected_truck)
        mytruck = selected_truck.pluck(:name)
        puts "Great choice! #{mytruck.join("")} is the food truck for you."
    end

    def self.truck_id(selected_truck)
        mytruck = selected_truck.pluck(:id)
    end
end