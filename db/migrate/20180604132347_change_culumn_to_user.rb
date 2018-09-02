class ChangeCulumnToUser < ActiveRecord::Migration[5.1]
  
  def change
    change_column :users, :last_name, :string, limit: 64, null: false
    change_column :users, :first_name, :string, limit: 32, null: false, unique: true

    rename_column :users, :last_name, :full_name
    rename_column :users, :first_name, :user_name

    add_index :users, :user_name, unique: true
  end

end
