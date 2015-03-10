class AddEnabledToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :enabled, :boolean, default: false, null: false
  end
end
