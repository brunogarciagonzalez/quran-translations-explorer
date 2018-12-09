class Verse < ApplicationRecord
  has_many :verse_notes
  belongs_to :chapter
  has_many :translations
end
