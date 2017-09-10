class ChangeUsersCurrencyType < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :currency, 'integer USING CAST(currency AS integer)'
  end
end
