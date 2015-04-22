class CreateComposition < ActiveRecord::Migration
  def change
    create_table :compositions do |t|
      t.references :component,  null: false
      t.references :composable, null: false, polymorphic: true

      t.timestamps null: false
    end

    add_index :compositions, [:component_id, :composable_id], unique: true
  end
end
