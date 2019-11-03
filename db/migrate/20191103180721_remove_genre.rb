class RemoveGenre < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :genre_id
    drop_table :genres
  end
end
