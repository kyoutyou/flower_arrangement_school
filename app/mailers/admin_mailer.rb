class AdminMailer < ApplicationMailer
  def inquiry_mail
    @user = User.find(params[:user])
    mail(to: @user.email, subject: '送信完了しました')
  end

end
