class CreateBackendApps < ActiveRecord::Migration
  def change
    create_table :backend_apps do |t|
      t.references :user, null: false
      t.string     :name
      t.string     :uid
      t.text       :description
      t.jsonb      :metadata, null: false, default: {}

      t.timestamps null: false
    end

    add_index :backend_apps, %i(name user_id), unique: true
    add_index :backend_apps, :uid, unique: true
  end
end
