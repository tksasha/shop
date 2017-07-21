class AddBelongsToOrderToPurchases < ActiveRecord::Migration[5.1]
  def change
    change_table :purchases do |t|
      t.belongs_to :order
    end

    add_column :orders, :purchases_count, :integer
  end
end
