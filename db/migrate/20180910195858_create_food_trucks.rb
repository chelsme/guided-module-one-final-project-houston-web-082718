class CreateFoodTrucks < ActiveRecord::Migration[5.0]
  def change
    create_table :food_trucks do |t|
      t.string :name
      t.string :food_type
    end
  end
end
