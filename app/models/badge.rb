class Badge < ApplicationRecord
  has_many :users_badges
  has_many :users, through: :users_badges

  before_save :set_default_image_path, unless: :image_path?

  validates :title, :image_path, :rule_value, presence: true
  validates :rule, presence: true, uniqueness: { scope: :rule_value }
  validates :rule, inclusion: { in: BadgeService::BADGES_TYPE }

  def self.images
    images_path = 'app/assets/images/'
    badges = Dir.glob("#{images_path}badges/*")
    badges.map { |badge_path| badge_path.gsub(images_path, '') }
  end

  private

  def set_default_image_path
    self.image_path = 'badges/badge-default.png'
  end
end
