class User < ApplicationRecord
  has_many :tests_user
  has_many :tests, through: :tests_user
  has_many :tests

  def tests_by_level(level)
    Test.joins("INNER JOIN tests_users ON tests_users.test_id = tests.id")
      .where(level: level, tests_users: { user_id: id })
  end
end
