class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :commentable, polymorphic: true, index: { name: 'commentable_index' }

      t.integer :commentator_id, index: true
      t.integer :reply_commentator_id, index: true
      t.boolean :enabled, null: false, default: true

      t.text :content

      t.timestamps
    end

  end
end
