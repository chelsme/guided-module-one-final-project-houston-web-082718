class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.belongs_to :food_truck
      t.belongs_to :customer
    end
  end
end
