class Public::CustomersController < ApplicationController
  def show
    @customer=current_user
  end

  def edit
  end

  def update
  end
end
