class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_save :before_save_find_question

  def test_passed?
    result_percent >= 85
  end

  def result_percent
    (100 * self.correct_questions) / test.questions.count
  end

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    self.correct_question += 1 if correct_answer?(answer_ids)
    save!
  end

  def current_question_number
    completed_questions.count + 1
  end


  private


  def correct_answer?(answer_ids)
    correct_answers.ids.sort == Array(answer_ids).map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end


  def before_save_find_question
    if current_question.nil?
      self.current_question = test.questions.first if test.present?
    else
      self.current_question = next_question
    end
  end

  def completed_questions
    test.questions.order(:id).where('id < ?', current_question.id)
  end
end
