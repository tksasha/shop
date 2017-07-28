class AddTrigramIndexes < ActiveRecord::Migration[5.1]
  def change
    execute 'CREATE EXTENSION IF NOT EXISTS pg_trgm;'

    execute 'CREATE INDEX index_products_on_name ON products USING GIST (name gist_trgm_ops);'

    execute 'CREATE INDEX index_categories_on_name ON categories USING GIST (name gist_trgm_ops);'
  end
end
