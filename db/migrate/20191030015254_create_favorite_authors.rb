class CreateFavoriteAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_authors do |t|
      t.references :user, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
