class AddOrderStatusToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :order_status, :string
  end
end
