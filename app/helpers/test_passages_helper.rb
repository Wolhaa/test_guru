module TestPassagesHelper
  def show_result_message(test_passage)
    @test_passage.test_passed? ? t('.success') : t('.failed')
  end

  def result_color(test_passing)
    test_passing.test_passed? ? 'text-success' : 'text-danger'
  end
end
