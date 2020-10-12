class FeedbackMailer < ApplicationMailer
  default to: -> { Admin.pluck(:email) }

  def send_feedback(feedback)
    @email   = feedback.email
    @subject = feedback.title
    @message = feedback.body

    mail from: @email, subject: @subject
  end
end
