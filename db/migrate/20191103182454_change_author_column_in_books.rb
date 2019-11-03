class ChangeAuthorColumnInBooks < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :author_id
    add_column :books, :author, :string
  end
end
