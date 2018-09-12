class Customer < ActiveRecord::Base
    has_many :orders
    has_many :food_trucks, through: :orders
    

    def new_order(truckid)
        order = gets.chomp
        Order.create(food_truck_id: truckid.join(""), customer_id: self.id, order_item: order, order_status: "open")
    end

    def view_order
        order = Order.where("customer_id = ?", self.id)
        order = order.first
        puts "You are customer number #{self.id}."
        puts "You ordered #{order.order_item}."
        puts "Your order status is #{order.order_status}."
    end

    def change_order
        order = Order.where("customer_id = ?", self.id)
        order = order.first
        puts "You ordered: #{order.order_item}."
        puts "What would you like instead?"
        new_order_item = gets.chomp
        order.order_item = new_order_item
        order.order_status = "changed"
        order.save
        order
        puts "You are customer number #{order.customer_id}."
        puts "You ordered #{order.order_item}."
        puts "Your order status is #{order.order_status}."
    end

    def cancel_order
        order = Order.where("customer_id = ?", self.id)
        order = order.first
        order.order_status = "canceled"
        order.save
        order
        puts "Your order has been canceled."
    end
end