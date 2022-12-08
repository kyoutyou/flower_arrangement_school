class Public::ReservationsController < ApplicationController
  def new
    @lesson = Lesson.find_by(lesson_datetime: params[:date].to_datetime)
    @date = params[:date]
  end
end
