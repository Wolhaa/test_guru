module TestPassagesHelper
  def show_result_message(test_passage)
    fail = test_passage.time_out? ? t('test_passings.result.time_failed') : t('test_passings.result.failed')
    test_passage.test_passed? ? t('.success') : fail
  end

  def result_color(test_passing)
    test_passing.test_passed? ? 'text-success' : 'text-danger'
  end

  def show_timer(test_passage)
    ((test_passage.created_at + test_passage.test.time_limit.minutes) - Time.current).to_i
  end
end
