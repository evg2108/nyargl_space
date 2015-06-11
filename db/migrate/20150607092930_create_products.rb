class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :slug, index: { unique: true }

      t.string :title, null: false
      t.string :description
      t.integer :age_restriction, default: '18', null: false, index: true

      t.decimal :price, precision: 15, scale: 2, default: BigDecimal('0'), null: false
      t.boolean :free, default: false, null: false, index: true

      t.json :pictures

      t.belongs_to :user, index: true

      t.boolean :enabled, default: false, null: false
      t.boolean :blocked, default: false, null: false

      t.timestamps null: false
    end
  end
end
