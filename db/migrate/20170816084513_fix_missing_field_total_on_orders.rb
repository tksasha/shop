class FixMissingFieldTotalOnOrders < ActiveRecord::Migration[5.1]
  def change
    unless column_exists? :orders, :total
      add_column :orders, :total, :decimal, precision: 10, scale: 2, null: false
    end
  end
end
