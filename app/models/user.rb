class User < ApplicationRecord
  has_many :tests_user, dependent: :destroy
  has_many :tests, through: :tests_user
  has_many :created_tests, class_name: 'Test', foreign_key: 'user_id', dependent: :destroy

  def tests_by_level(level)
    tests.where(level: level)
  end
end
