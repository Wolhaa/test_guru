class Test < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :questions, dependent: :nullify
  has_many :tests_users, dependent: :nullify
  has_many :users, through: :tests_users

  def self.by_category(category)
    joins(:category).where(categories: { title: name }).order(title: :desc).pluck(:title)
  end
end
