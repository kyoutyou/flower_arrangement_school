class Public::ReservationsController < ApplicationController
  def edit
    @reservation = Reservation.find_by(user_id: current_user.id)
    @date = params[:date]
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update(reservation_params)
    redirect_to home_calendar_path
  end

  private
  def reservation_params
    params.require(:reservation).permit(:lesson_datetime)
  end
end
