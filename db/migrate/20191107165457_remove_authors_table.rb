class RemoveAuthorsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :favorite_authors
    drop_table :authors
  end
end
