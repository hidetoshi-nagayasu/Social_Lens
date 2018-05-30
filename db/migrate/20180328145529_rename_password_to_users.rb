class RenamePasswordToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :password, :encrypted_password
    rename_column :users, :current_login_at, :current_sign_in_at
    rename_column :users, :last_login_at, :last_sign_in_at
  end
end
