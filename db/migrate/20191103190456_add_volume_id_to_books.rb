class AddVolumeIdToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :volume_id, :string
  end
end
