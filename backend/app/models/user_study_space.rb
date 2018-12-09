class UserStudySpace < ApplicationRecord
   # can add admin true/false to this table
  belongs_to :user
  belongs_to :study_space
end
