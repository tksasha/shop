class ChangeProductsSimilaritiesNull < ActiveRecord::Migration[5.1]
  def change
    change_column_null :products, :similarities, false, []
  end
end
