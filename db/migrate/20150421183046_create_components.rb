class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :name,   null: false
      t.jsonb  :models, null: false, default: {}

      t.timestamps null: false
    end

    add_index :components, :name, unique: true
  end
end
