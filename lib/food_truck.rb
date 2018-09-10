class FoodTruck < ActiveRecord::Base
    has_many :orders
    has_many :customers, through: :orders

    def self.type_of_food
        self.all.map do |truck|
            truck.food_type
        end
    end

end