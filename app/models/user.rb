class User < ApplicationRecord
  def tests_by_level(level)
    Test.joins("INNER JOIN users_tests ON users_tests.test_id = tests.id")
      .where(level: level, users_tests: { user_id: id })
  end
end
