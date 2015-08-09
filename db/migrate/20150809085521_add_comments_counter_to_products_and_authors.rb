class AddCommentsCounterToProductsAndAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :comments_count, :integer, null: false, default: 0
    add_column :products, :comments_count, :integer, null: false, default: 0
  end
end
