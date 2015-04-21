class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string  :name, null: false
      t.integer :packages_count, default: 0

      t.timestamps null: false
    end

    add_index :components, :name, unique: true
  end
end
