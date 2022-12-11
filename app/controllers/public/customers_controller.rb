class Public::CustomersController < ApplicationController
  def show
    @customer=current_user
  end

  def edit
    @public_customer=current_user
  end

  def update
    @public = current_user
    @public.update(customer_params)
    redirect_to public_customer_path(current_user)
  end

  private
  def customer_params
    params.require(:user).permit(:last_name,:first_name,:last_name_kana,:first_name_kana, :postal_code, :address, :telephone_number,:is_deleted,:email)
  end

end
