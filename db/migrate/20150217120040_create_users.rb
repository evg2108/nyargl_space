class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :temporary_token
      t.string :role
      t.boolean :confirmed_email, default: false, null: false

      t.timestamps null: false
    end
  end
end
