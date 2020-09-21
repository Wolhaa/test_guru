module TestPassagesHelper
  def result_message(test_passage)
    action = test_passage.test_passed? ? 'completed' : 'failed'
    "You #{action} the test."
  end
end
