class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.references :tokenable, polymorphic: true
      t.references :user,      null: false
      t.string     :token,     null: false
      t.string     :type,      null: false
      t.string     :tokenable_uid
      t.datetime   :deleted_at
      t.datetime   :expires_at

      t.timestamps null: false
    end

    add_index :tokens, :deleted_at, where: "deleted_at IS NULL"
    add_index :tokens, :tokenable_id
    add_index :tokens, :tokenable_type
    add_index :tokens, %i(token type), unique: true
    add_index :tokens, :user_id
  end
end
