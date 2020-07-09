class User < ApplicationRecord
  has_many :tests_user, dependent: :nullify
  has_many :tests, through: :tests_user
  has_many :created_tests, class_name: 'Test', foreign_key: 'user_id'

  def tests_by_level(level)
    tests.where(level: level)
  end
end
