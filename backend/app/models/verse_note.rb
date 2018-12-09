class VerseNote < ApplicationRecord
  belongs_to :study_space
  has_many :verse_note_histories
  belongs_to :verse
end
