class Note < ApplicationRecord


   validates :name, presence: true

   #validates :tags, allow_nil: true
   # validates :name, {allow_nil: false}

  belongs_to :book

  #validates :name
  #validates :body

end
