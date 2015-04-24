class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.references :liable, polymorphic: true
      t.string     :brand
      t.string     :name
      t.string     :type
      t.string     :uid

      t.timestamps null: false
    end

    add_index :payment_methods, :liable_id
    add_index :payment_methods, :type
  end
end
