class Option < ApplicationRecord
  belongs_to :optionable, polymorphic: true
  validates :video_quality, :price, presence: true
  validate :duplicate_option

  private
  def duplicate_option
    unless self.class.find_by(video_quality: self.video_quality, optionable_type: self.optionable_type, optionable_id: self.optionable_id).nil?
      errors.add(:duplicate, "option does't allow.")
    end
  end

end
