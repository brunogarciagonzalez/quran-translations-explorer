class ChapterNoteHistory < ApplicationRecord
  belongs_to :chapter_note
  belongs_to :user
end
