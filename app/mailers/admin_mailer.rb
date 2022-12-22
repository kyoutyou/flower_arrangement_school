class AdminMailer < ApplicationMailer
  def inquiry_mail(subject, name, body)
    @name = name
    @body = body
    # ユーザー一斉送信
    user_emails = User.where(is_deleted: false).collect(&:email).join(',')
    mail(to: ENV['ADMIN_CONTACT_EMAIL'], bcc: user_emails, subject: subject)
  end

end
