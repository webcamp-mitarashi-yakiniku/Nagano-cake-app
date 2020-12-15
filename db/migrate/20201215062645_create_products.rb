class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|

      t.timestamps
      t.integer :genre_id, null: false
      t.string :image_id, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.boolean :on_sale_status, null: false, default: true
    end
  end
end
