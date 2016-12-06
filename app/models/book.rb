require 'csv'

class Book < ApplicationRecord

  validates :name, presence: { message: "не может быть пустым" }

  has_many :notes
  has_many :taggings
  has_many :tags, through: :taggings

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["id","name","access"]
      all.each do |book|
        csv << book.attributes.values_at(*["id","name","access"])
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      book = find_by_id(row["id"]) || new
      book.attributes = row.to_hash.slice(*column_names)
      book.save!
    end
  end



  def all_tags
     self.tags.map(&:name).join(', ')
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
end
