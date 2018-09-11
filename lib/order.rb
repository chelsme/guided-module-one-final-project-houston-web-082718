class Order < ActiveRecord::Base
    belongs_to :customer
    belongs_to :food_truck

    def self.new_order
        puts "FOOD!"
    end
end