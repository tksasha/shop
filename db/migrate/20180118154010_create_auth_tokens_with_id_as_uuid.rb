class CreateAuthTokensWithIdAsUuid < ActiveRecord::Migration[5.1]
  def change
    enable_extension :pgcrypto

    create_table :auth_tokens, id: :uuid do |t|
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
