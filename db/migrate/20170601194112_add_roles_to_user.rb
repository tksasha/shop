class AddRolesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :roles, :integer
  end
end
