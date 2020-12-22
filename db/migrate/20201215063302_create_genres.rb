class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|

      t.timestamps
      t.string :name, null: false
      t.boolean :is_active, null: false, default: true
    end
  end
end
