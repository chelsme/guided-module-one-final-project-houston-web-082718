class Customer < ActiveRecord::Base
    has_many :orders
    has_many :food_trucks, through: :orders
    

    def new_order(truckid)
        order = gets.chomp
        Order.new(food_truck_id: truckid.join(""), customer_id: self.id, order_item: order)
    end
end