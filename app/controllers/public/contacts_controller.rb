class Public::ContactsController < ApplicationController
  def confirm
    
  end
  def create
  @body = params[:body]
  @email = current_user ? current_user.email : params[:email]
  @name = params[:name]
  UserMailer.inquiry_mail(@email,@name,@body).deliver_later
  redirect_to public_contacts_thanks_path
  end
end
