class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :name, null: false
      t.jsonb  :models, default: {}
    end

    add_index :components, :name, unique: true
  end
end
