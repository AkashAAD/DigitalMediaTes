class Library < ApplicationRecord
  belongs_to :contentable, polymorphic: true
  belongs_to :user

  validate :duplicate_library

  def self.delete_expired_libraries
    my_logger ||= Logger.new("#{Rails.root}/log/cron_job.log")
    self.where("DATE(created_at) <= ?", Date.today + 3.days).destroy_all
    my_logger.info("Expired Libraries has been deleted successfully.")
  end

  private
  def duplicate_library
    unless self.class.find_by(option_id: self.option_id, contentable_type: self.contentable_type, contentable_id: self.contentable_id).nil?
      errors.add(:user, "Duplicate option does't allow.")
    end
  end
end
