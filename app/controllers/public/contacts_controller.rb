class Public::ContactsController < ApplicationController
  def creat
  @user=current_user
  @body=params[:body]
  UserMailer.inquiry_mail.deliver_later
  redirect_to public_contacts_thanks_path
  end
end
