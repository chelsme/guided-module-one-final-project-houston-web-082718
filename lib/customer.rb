class Customer < ActiveRecord::Base
    has_many :orders
    has_many :food_trucks, through: :orders
    

    def new_order(truckid)
        order = gets.chomp.downcase
        Order.create(food_truck_id: truckid.join(""), customer_id: self.id, order_item: order, order_status: "open")
    end

    def view_newest_order
        order = Order.where("customer_id = ?", self.id)
        order = order.last
        puts "You are customer number #{self.id}.".colorize(:light_red)
        puts "You ordered #{order.order_item}.".colorize(:light_red)
        puts "Your order status is #{order.order_status}.".colorize(:light_red)
    end

    def view_all_orders(new_name)
        customer = Customer.where("name = ?", new_name)
        id = customer.pluck(:id)
        orders = Order.where("customer_id = ?", id)
        puts "You have the following orders:".colorize(:light_blue)
            orders.each do |order|
                truck_id = order.food_truck_id
                truck = FoodTruck.where("id = ?", truck_id)
                puts "Truck: #{truck.first.name}, Order: #{order.order_item}, Status, #{order.order_status}".colorize(:light_red)
            end
    end

    def change_newest_order
        order = Order.where("customer_id = ?", self.id)
        order = order.last
        puts "You ordered: #{order.order_item}.".colorize(:light_blue)
        puts "What would you like instead?".colorize(:cyan)
        new_order_item = gets.chomp.downcase
        order.order_item = new_order_item
        order.order_status = "changed"
        order.save
        order
        puts "You are customer number #{order.customer_id}.".colorize(:light_red)
        puts "You ordered #{order.order_item}.".colorize(:light_red)
        puts "Your order status is #{order.order_status}.".colorize(:light_red)
    end

    def cancel_newest_order
        order = Order.where("customer_id = ?", self.id)
        order = order.last
        order.order_status = "canceled"
        order.save
        order
        puts "Your order has been canceled.".colorize( :background => :red)
    end
end