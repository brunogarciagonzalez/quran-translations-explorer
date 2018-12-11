class User < ApplicationRecord
  has_many :user_study_spaces
  has_many :study_spaces, through: :user_study_spaces
  has_many :chapter_note_histories
  has_many :chapter_notes, through: :chapter_note_histories
  has_many :verse_note_histories
  has_many :verse_notes, through: :verse_note_histories
  has_many :announcements
end
