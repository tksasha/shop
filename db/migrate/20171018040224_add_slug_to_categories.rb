class AddSlugToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :slug, :string, index: true, null: false
  end
end
