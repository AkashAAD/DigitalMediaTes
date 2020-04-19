class Episode < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  belongs_to :season
end
