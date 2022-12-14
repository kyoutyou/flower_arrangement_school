class Public::ContactsController < ApplicationController
  def new
  end

  def confirm
    @name = params[:name]
    @body = params[:body]
  end

  def create
    @body = params[:body]
    @email = current_user ? current_user.email : params[:email]
    @name = params[:name]
    UserMailer.inquiry_mail(@email,@name,@body).deliver_later
    redirect_to public_contacts_thanks_path
  end
end
