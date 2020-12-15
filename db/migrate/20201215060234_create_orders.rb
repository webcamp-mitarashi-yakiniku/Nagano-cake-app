class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.timestamps
      t.integer :customer_id, null: false
      t.string :name, null: false
      t.string :post_code, null: false
      t.string :address, null: false
      t.integer :account, null: false
      t.integer :shipping, null: false
      t.integer :payment_method, null: false
      t.integer :order_status, null: false, default: 0
    end
  end
end
