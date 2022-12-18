class UserMailer < ApplicationMailer
  def inquiry_mail(email,name,body)
    @name = name
    @body = body
    mail(to: email, bcc: Admin.first.email, subject: 'お問い合わせありがとうございます')
  end
end
