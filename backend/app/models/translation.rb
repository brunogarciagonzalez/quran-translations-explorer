class Translation < ApplicationRecord
  has_many :chapters
  has_many :verses, through: :chapters
end
