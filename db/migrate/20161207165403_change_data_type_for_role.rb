class ChangeDataTypeForRole < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :role, 'integer USING CAST(role AS integer)'
  end
end
