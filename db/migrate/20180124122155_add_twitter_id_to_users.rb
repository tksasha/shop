class AddTwitterIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :twitter_id, :string

    add_index :users, :twitter_id
  end
end
