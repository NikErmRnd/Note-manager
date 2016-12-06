class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :picture
      t.integer :imageable_id
      t.string :imageable_type #Book, Note
      t.timestamps
    end

    add_index :images, [:imageable_id, :imageable_type]
  end
end

