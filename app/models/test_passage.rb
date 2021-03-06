class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_save :before_save_find_question

  def test_passed?
    result_percent >= 85
  end

  def result_percent
    (100 * self.correct_question) / test.questions.count
  end

  def accept!(answer_ids)
    self.correct_question += 1 if correct_answer?(answer_ids)
    self.passed = true if test_passed?
    self.current_question = nil if time_out?

    save!
  end

  def current_question_number
    completed_questions.count + 1
  end

  def completed?
    current_question.nil?
  end

  def time_limit_test?
    test.time_limit.present?
  end

  def remaining_seconds
    ((created_at + test.time_limit.minutes) - Time.current).to_i
  end

  def time_out?
    (created_at + test.time_limit.minutes < Time.current) if time_limit_test?
  end

  private


  def correct_answer?(answer_ids)
    correct_answers.ids.sort == Array(answer_ids).map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
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

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end
end
