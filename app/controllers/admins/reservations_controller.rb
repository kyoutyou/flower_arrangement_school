class Admins::ReservationsController < ApplicationController
  def index
    if params[:sort] == "lesson_datetime"
      @reservations = Reservation.order('lesson_datetime ASC')
    elsif params[:sort] == "user.name"
      @reservations = Reservation.includes(:user).sort {|a,b| a.user.first_name_kana <=> b.user.first_name_kana}
    else
      @reservations = Reservation.all
    end
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
