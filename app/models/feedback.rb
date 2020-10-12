class Feedback
  include ActiveModel::Model

  attr_accessor :email, :title, :body

  validates_presence_of :title, :email, :body
  validates_format_of :email, with: /.+@.+/
end
