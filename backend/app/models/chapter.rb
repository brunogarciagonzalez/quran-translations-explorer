class Chapter < ApplicationRecord
  belongs_to :translation
  has_many :verses
end
