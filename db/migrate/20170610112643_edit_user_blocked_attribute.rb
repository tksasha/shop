class EditUserBlockedAttribute < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :blocked, :boolean, default: false, null: false
  end
end
