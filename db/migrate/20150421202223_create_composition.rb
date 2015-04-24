class CreateComposition < ActiveRecord::Migration
  def change
    create_table :compositions do |t|
      t.references :component,  null: false
      t.references :composable, null: false, polymorphic: true

      t.timestamps null: false
    end

    add_index :compositions, %i(component_id composable_id composable_type),
      name: "index_compositions_on_component_and_composable", unique: true
  end
end
