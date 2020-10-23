class BadgeService
  BADGES_TYPE = %i[all_category_tests first_attempt all_level_tests].freeze

  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
  end

  def give_badges
    Badge.all.select { |badge| send("#{badge.rule}_award", badge) }
  end

  private

  def all_category_tests_award(badge)
    return false unless @test_passage.passed = false || badge.rule_value == @test_passage.test.category.title
    badge.rule_value == @test_passage.test.category.title && all_category_tests?(badge.rule_value)
  end

  def first_attempt_award(badge)
    return false unless @test_passage.passed = false
    first_attempt?
  end

  def all_level_tests_award(badge)
    return false unless @test_passage.passed = false || badge.rule_value.to_i == @test_passage.test.level
    badge.rule_value.to_i == @test_passage.test.level && all_level_tests?(badge.rule_value)
  end

  def all_category_tests?(badge)
    last_badge_time = UsersBadge.where(badge: badge).order(created_at: :desc).first&.created_at
    passed_tests_by_category = @user.tests.where('test_passages.passed = ?', true).by_category(badge.rule_value)
    if last_badge_time.present?
      uniq_passed_tests_by_category = passed_tests_by_category.where('test_passages.created_at > ?', last_badge_time).uniq { |test| test[:id] }
    else
      uniq_passed_tests_by_category = passed_tests_by_category.uniq { |test| test[:id] }
    end
    Test.by_category(category).count == uniq_passed_tests_by_category.count
  end

  def all_level_tests?(badge)
    last_badge_time = UsersBadge.where(badge: badge).order(created_at: :desc).first&.created_at
    passed_tests_by_level = @user.tests.where('test_passages.passed = ?', true).by_level(badge.rule_value.to_i)
    if last_badge_time.present?
      uniq_passed_tests_by_level = passed_tests_by_level.where('test_passages.created_at > ?', last_badge_time).uniq { |test| test[:id] }
    else
      uniq_passed_tests_by_level = passed_tests_by_level.uniq { |test| test[:id] }
    end
    Test.by_level(level.to_i).count == uniq_passed_tests_by_level.count
  end

  def first_attempt?
    @user.tests.where(id: @test_passage.test_id).count == '1'
  end
end
