class Season < ApplicationRecord
  has_many :episodes
  validates :title, presence: true, uniqueness: true
  has_many :libraries, as: :contentable
  has_many :options, as: :optionable
end
