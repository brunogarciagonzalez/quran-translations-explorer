class Announcement < ApplicationRecord
  belongs_to :study_space
  belongs_to :user
end
