class CreateVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :versions, id: false do |t|
      t.string :ios_minimal_recomended, default: '0.0.0'
      t.string :ios_minimal_compatible, default: '0.0.0'
      t.string :ios_blocked, array: true, default: []

      t.string :android_minimal_recomended, default: '0.0.0'
      t.string :android_minimal_compatible, default: '0.0.0'
      t.string :android_blocked, array: true, default: []

      t.timestamps
    end
  end
end
