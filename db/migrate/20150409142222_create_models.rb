class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.references :backend_app, null: false
      t.jsonb      :schema,      null: false, default: {}
      t.string     :name,        null: false
      t.text       :description

      t.timestamps null: false
    end

    add_index :models, %i(backend_app_id name), unique: true
  end
end
