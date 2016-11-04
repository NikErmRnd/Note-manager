class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string :name
      t.text :body
      t.text :tags

      t.timestamps
    end
  end
end
