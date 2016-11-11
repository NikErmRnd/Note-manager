class FixColumnNotebook < ActiveRecord::Migration[5.0]
  def change
    rename_column :notes, :notebook, :book_id
  end
end
