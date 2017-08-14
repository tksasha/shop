class AddSimilaritiesToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :similarities, :jsonb
  end
end
