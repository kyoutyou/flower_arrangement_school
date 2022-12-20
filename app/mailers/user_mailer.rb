class UserMailer < ApplicationMailer
  def inquiry_mail(email,name,body)
    @name = name
    @body = body

    # admin_emails = Admin.all.collect(&:email).join(',')

    mail(to: email, bcc: ENV['ADMIN_CONTACT_EMAIL'], subject: 'お問い合わせありがとうございます')
  end
end
