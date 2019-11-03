class AddSubtitleColumnToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :subtitle, :string
  end
end
