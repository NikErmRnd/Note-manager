class AddAccessAndNotebookColumnToNotes < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :access, :string
    add_column :notes, :notebook, :string
  end
end
