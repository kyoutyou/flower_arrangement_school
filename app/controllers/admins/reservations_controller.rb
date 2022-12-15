class Admins::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
    # @user=User.find(params[:id])
    @date = params[:date]
  end

  def edit
    @reservation = Reservation.find_by(params[:user_id])
    @date = params[:date]
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update(reservation_params)
    redirect_to admins_reservations_path
  end

  private
  def reservation_params
    params.require(:reservation).permit(:lesson_datetime)
  end
end
