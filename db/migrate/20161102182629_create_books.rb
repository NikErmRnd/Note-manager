class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :access
      t.text :tags

      t.timestamps
    end
  end
end
