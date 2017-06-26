class DeleteBlockedFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :blocked
  end
end
