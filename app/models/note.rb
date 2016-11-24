class Note < ApplicationRecord


   validates :name, presence: { message: "не может быть пустым" }

  belongs_to :book


end
