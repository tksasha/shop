class AddBelongsToUserToOrders < ActiveRecord::Migration[5.1]
  def change
    change_table :orders do |t|
      t.belongs_to :user
    end
  end
end
