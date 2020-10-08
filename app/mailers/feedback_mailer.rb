class FeedbackMailer < ApplicationMailer
  def send_feedback(feedback)
    @email   = feedback.email
    @subject = feedback.title
    @message = feedback.body

    default to: -> { Admin.pluck(:email) }, from: @email, subject: @subject
  end
end
