class AddForeignKeys < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :auth_tokens, :users

    add_foreign_key :categories_products, :categories

    add_foreign_key :categories_products, :products

    add_foreign_key :orders, :users

    add_foreign_key :purchases, :orders
  end
end
