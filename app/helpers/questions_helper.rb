module QuestionsHelper
  def question_header(question)
    if question.new_record?
      "Creating a new question for test #{question.test.title}"
    else
      "Edit question for test #{question.test.title}"
    end
  end
end
