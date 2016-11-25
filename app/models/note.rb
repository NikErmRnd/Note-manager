class Note < ApplicationRecord

   belongs_to :book

   validates :name, presence: { message: "не может быть пустым" }

end
