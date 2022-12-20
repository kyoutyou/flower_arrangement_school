class Admins::ContactsController < ApplicationController
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
    AdminMailer.inquiry_mail(@email,@name,@body).deliver_later
    redirect_to admins_root_path
  end
end
