class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :first_name
      t.string :last_name
      t.string :patronymic
      t.text :about_author
      t.string :avatar
      t.json :photos

      t.string :slug, index: { unique: true }

      t.references :user, index: true

      t.boolean :enabled, default: false, null: false

      t.timestamps null: false
    end
  end
end
