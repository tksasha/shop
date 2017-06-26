class CreateAuthTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :auth_tokens do |t|
      t.belongs_to :user, index: true
      t.string :value

      t.timestamps
    end
  end
end
