class Note < ApplicationRecord



   belongs_to :book

   validates :name, presence: { message: "не может быть пустым" }

=begin
   def self.import(file)

      CSV.foreach(file.path, headers: true) do |row|

         Note.create! row.to_hash
      end

   end
=end

end
