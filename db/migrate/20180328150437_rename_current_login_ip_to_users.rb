class RenameCurrentLoginIpToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :current_login_ip, :current_sign_in_ip
    rename_column :users, :last_login_ip, :last_sign_in_ip
  end
end
