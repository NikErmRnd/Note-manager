class ChangeRolesOnUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :roles_mask, :role
  end
end
