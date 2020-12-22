class AddCustomerToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :family_name, :string
    change_column :customers, :family_name, :string, null: false
    add_column :customers, :first_name, :string
    change_column :customers, :first_name, :string, null: false
    add_column :customers, :family_name_kana, :string
    change_column :customers, :family_name_kana, :string, null: false
    add_column :customers, :first_name_kana, :string
    change_column :customers, :first_name_kana, :string, null: false
    add_column :customers, :post_code, :string
    change_column :customers, :post_code, :string, null: false
    add_column :customers, :address, :string
    change_column :customers, :address, :string, null: false
    add_column :customers, :phone_number, :string
    change_column :customers, :phone_number, :string, null: false
    add_column :customers, :is_active, :boolean, default: true
    change_column :customers, :is_active, :boolean, default: true, null: false
  end
end
