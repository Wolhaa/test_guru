module TestsHelper
  def test_header(test)
    if test.new_record?
      t('.create')
    else
      t('.update')
    end
  end
end
