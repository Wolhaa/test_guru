class Badge < ApplicationRecord
  BADGES_TYPE = {
    'Прохождение всех тестов категории' => :all_category_tests,
    'Прохождение теста с первой попытки' => :test_first_try,
    'Прохождение всех тестов определнного уровня' => :all_level_tests
  }.freeze

  has_many :users_badges
  has_many :users, through: :users_badges
  belongs_to :category, class_name: 'Category', optional: true

  before_save :set_default_image_path, unless: :image_path?

  validates :title, presence: true
  validates :rule, presence: true

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
