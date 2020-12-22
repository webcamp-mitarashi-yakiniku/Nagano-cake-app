class CreateCartProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_products do |t|

      t.timestamps
      t.integer :product_id, null: false
      t.integer :customer_id, null: false
      t.integer :product_quantity, null: false
    end
  end
end
