class Chapter < ApplicationRecord
  has_many :chapter_notes
  has_many :verses
  has_many :translations, through: :verses
end
