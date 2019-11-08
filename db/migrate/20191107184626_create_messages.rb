class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :book_club, null: false, foreign_key: true

      t.timestamps
    end
  end
end
