class StudySpace < ApplicationRecord
  has_many :user_study_spaces
  has_many :users, through: :user_study_spaces

  has_many :chapter_notes
  has_many :chapter_note_histories, through: :chapter_notes

  has_many :verse_notes
  has_many :verse_note_histories, through: :verse_notes

  has_many :announcements
end
