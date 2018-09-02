class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.text :text, null: false

      # Common
      t.string :created_by, limit: 32
      t.string :updated_by, limit: 32
      t.timestamps null: false
      t.integer :is_deleted, null: false, default: 0, limit: 1
      t.datetime :deleted_at
    end
  end
end
