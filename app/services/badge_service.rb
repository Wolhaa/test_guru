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
    Badge.all.map { |badge| send("#{badge.rule}_award", badge) }.compact
  end

  private

  def all_category_tests_award(badge)
    badge if all_category_tests?(badge.rule_value) && badge.rule_value == @test_passage.test.category.title
  end

  def first_attempt_award(badge)
    badge if first_attempt?(badge.rule_value)
  end

  def all_level_tests_award(badge)
    badge if all_level_tests?(badge.rule_value) && badge.rule_value.to_i == @test_passage.test.level
  end

  def all_category_tests?(category)
    Test.with_questions.by_category(category).count == @user.tests.where('test_passages.passed = ?', true).by_category(category).count
  end

  def all_level_tests?(level)
    Test.with_questions.by_level(level.to_i).count == @user.tests.where('test_passages.passed = ?', true).by_level(level.to_i).count
  end

  def first_attempt?(attempts)
    @user.tests.where(id: @test_passage.test_id).count == attempts.to_i
  end
end
