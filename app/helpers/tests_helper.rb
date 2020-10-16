module TestsHelper
  def test_header(test)
    if test.new_record?
      t('.create')
    else
      t('.update')
    end
  end

  def test_time_limit(test)
    test.time_limit ? t('.time_limit', time: test.time_limit) : t('.unlimited')
  end
end
