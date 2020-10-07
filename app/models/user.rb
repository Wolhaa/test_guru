class User < ApplicationRecord

  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages
  has_many :created_tests, class_name: 'Test', foreign_key: 'user_id', dependent: :destroy
  has_many :gists, dependent: :destroy
  has_many :feedbacks, dependent: :destroy  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def tests_by_level(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test: test)
  end

  def admin?
    is_a?(Admin)
  end
end
