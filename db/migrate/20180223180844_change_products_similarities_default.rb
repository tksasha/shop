class ChangeProductsSimilaritiesDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :products, :similarities, from: nil, to: []
  end
end
