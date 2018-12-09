class ChapterNote < ApplicationRecord
  belongs_to :study_space
  has_many :chapter_note_histories
  belongs_to :chapter
end
