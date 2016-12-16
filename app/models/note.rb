class Note < ApplicationRecord

   has_many :images, as: :imageable, dependent: :destroy

   belongs_to :book

   validates :name, presence: { message: "не может быть пустым" }

   def self.to_csv(options = {})
      CSV.generate(options) do |csv|
         csv << ["id","name","body","access","book_id"]
         all.each do |note|
            csv << note.attributes.values_at(*["id","name","body","access","book_id"])
         end
      end
   end

   def self.import(file)
      CSV.foreach(file.path, headers: true) do |row|
         note = find_by_id(row["id".to_i]) || new
         note.attributes = row.to_hash.slice(*column_names)
         note.save!
      end
   end

end
