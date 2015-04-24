class CreateModelComposition < ActiveRecord::Migration
  def change
    create_table :model_compositions do |t|
      t.references :composition, null: false
      t.references :model,       null: false

      t.timestamps null: false
    end

    add_index :model_compositions, %i(composition_id model_id), unique: true
  end
end
