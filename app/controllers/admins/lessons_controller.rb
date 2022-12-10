class Admins::LessonsController < ApplicationController
  def index
    @lesson=Lesson.new
    @lessons=Lesson.all
  end

  def edit
    @lesson=Lesson.find(params[:id])
  end

  def create
    @lesson=Lesson.new(lesson_params)
    @lesson.save
    redirect_to admins_lessons_path
  end

  def update
    @lesson = Lesson.find(params[:id])
    @lesson.update(lesson_params)
    redirect_to admins_lessons_path
  end

  private
  def lesson_params
    params.require(:lesson).permit(:name)
  end
end
