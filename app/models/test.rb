class Test < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages

  scope :level, ->(level) { where(level: level) }
  scope :easy, -> { level(0..1) }
  scope :medium, -> { level(2..4) }
  scope :medium, -> { level(5..Float::INFINITY) }
#  scope :by_category, -> (name) { joins(:category).where(categories: { title: name }).order(title: :desc) }
  scope :by_category, ->(title) { joins(:category).where(categories: { title: title }) }

  validates :title, presence: true
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, uniqueness: { scope: :level }

  def self.titles_by_category(name)
    by_category(name).pluck(:title)
  end
end
