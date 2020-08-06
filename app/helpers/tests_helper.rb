module TestsHelper
  def test_header(test)
    if test.new_record?
      "Create new test"
    else
      "Edit test"
    end
  end
end
