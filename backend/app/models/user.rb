class User < ApplicationRecord
  has_many :user_study_spaces
  has_many :study_spaces, through: :user_study_spaces
end
