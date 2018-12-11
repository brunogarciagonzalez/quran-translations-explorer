class VerseNoteHistory < ApplicationRecord
  belongs_to :verse_note
  belongs_to :user
end
