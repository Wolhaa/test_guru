class BadgeService
  BADGES_TYPE = %i[all_category_tests first_attempt all_level_tests].freeze

  RULE_VALUES = [
    '0-easy',
    '1-elementary',
    '2-advanced',
    '3-hard',
    '1',
    'Математика',
    'Русский язык'].freeze

  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
  end

  def give_badges
    Badge.all.select { |badge| send("#{badge.rule}_award", badge) }
    byebug
  end

  private

  def all_category_tests_award(badge)
    badge if badge.rule_value == @test_passage.test.category.title && all_category_tests?(badge.rule_value)
  end

  def first_attempt_award(badge)
    badge if first_attempt?(badge.rule_value)
  end

  def all_level_tests_award(badge)
    return false unless @test_passage.passed = false
    badge if all_level_tests?(badge.rule_value) && badge.rule_value.to_i == @test_passage.test.level
  end

  def all_category_tests?(category)
    passed_tests_by_category = @user.tests.where('test_passages.passed = ?', true).by_category(category)
    uniq_passed_tests_by_category = passed_tests_by_category.uniq { |test| test[:id] }
    byebug
    Test.by_category(category).count == uniq_passed_tests_by_category.count
  end

  def all_level_tests?(level)
    passed_tests_by_level = @user.tests.where('test_passages.passed = ?', true).by_level(level.to_i)
    uniq_passed_tests_by_level = passed_tests_by_level.uniq { |test| test[:id] }
    Test.by_level(level.to_i).count == uniq_passed_tests_by_level.count
  end

  def first_attempt?(attempts)
    @user.tests.where(id: @test_passage.test_id).count == attempts.to_i
  end
end
