class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :email
      t.string   :first_name
      t.string   :last_name
      t.string   :password_digest
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :users, :email
    add_index :users, :deleted_at, where: "deleted_at IS NULL"
  end
end
