class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :description
      t.integer :last_blog_post_ids, null: false, default: [], array: true

      t.belongs_to :user

      t.timestamps
    end
  end
end
