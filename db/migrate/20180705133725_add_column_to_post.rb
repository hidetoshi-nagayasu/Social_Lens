class AddColumnToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :is_deleted, :integer, null: false, default: 0, limit: 1
    add_column :posts, :deleted_at, :datetime
  end
end
