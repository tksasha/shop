class RenameUserToProfile < ActiveRecord::Migration[5.1]
  def change
    rename_table :users, :profiles
  end
end
