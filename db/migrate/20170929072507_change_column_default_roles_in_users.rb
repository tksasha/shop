class ChangeColumnDefaultRolesInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :roles, 1
  end
end
