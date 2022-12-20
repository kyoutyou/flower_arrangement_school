class AdminMailer < ApplicationMailer
  def inquiry_mail(subject, body)
    @body = body
    # ユーザー一斉送信
    user_emails = User.all.collect(&:email).join(',')
    mail(to: ENV['ADMIN_CONTACT_EMAIL'], bcc: user_emails, subject: subject)
  end

end
