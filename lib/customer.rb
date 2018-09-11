class Customer < ActiveRecord::Base
    has_many :orders
    has_many :food_trucks, through: :orders

    # def new_order(self, item )
        
    # end
end