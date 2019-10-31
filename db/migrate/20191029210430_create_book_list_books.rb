class CreateBookListBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :book_list_books do |t|
      t.references :book, null: false, foreign_key: true
      t.references :book_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
