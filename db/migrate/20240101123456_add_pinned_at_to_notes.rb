class AddPinnedAtToNotes < ActiveRecord::Migration[8.0]
  def change
    add_column :notes, :pinned_at, :datetime
    add_index :notes, :pinned_at
  end
end