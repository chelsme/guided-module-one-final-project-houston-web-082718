class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.belongs_to :food_truck
      t.string :menu_item
    end
  end
end