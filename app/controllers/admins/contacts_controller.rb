class Admins::ContactsController < ApplicationController
  def new
  end

  def confirm
    @subject = params[:subject]
    @name = params[:name]
    @body = params[:body]
  end

  def create
    AdminMailer.inquiry_mail(params[:subject], params[:name], params[:body]).deliver_later
    redirect_to admins_root_path
  end
end
