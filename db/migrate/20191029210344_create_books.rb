class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.references :author, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.string :publisher
      t.string :published_date
      t.float :average_rating
      t.integer :page_count
      t.string :image
      t.string :description
      t.string :url

      t.timestamps
    end
  end
end
