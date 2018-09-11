class AddOrderItemToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :order_item, :string
  end
end
