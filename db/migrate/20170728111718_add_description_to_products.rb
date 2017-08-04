class AddDescriptionToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :description, :text

    add_column :products, :description_tsvector, :tsvector

    execute <<SQL
CREATE INDEX
  description_tsvector_index
ON
  products
USING GIN
  (description_tsvector);

CREATE TRIGGER
  description_tsvector_update
BEFORE
  INSERT OR UPDATE
ON
  products
FOR EACH ROW EXECUTE PROCEDURE
  tsvector_update_trigger(description_tsvector, 'pg_catalog.english', description);
SQL
  end
end
