class AddConfirmationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :confirmed, :boolean, default: false, null: false
    add_column :users, :confirmation_token, :string
  end
end
