class UserMailer < ApplicationMailer
  def inquiry_mail
    mail(to: @user.email, subject: 'お問い合わせありがとうございます')

    @admin = Admin.first()
    mail(to: @admin.email, subject: '問い合わせがありました。', body: @body)
  end

end
