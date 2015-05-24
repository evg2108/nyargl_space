class AddPhotosToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :photos, :json
  end
end
