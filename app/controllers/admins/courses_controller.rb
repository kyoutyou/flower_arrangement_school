class Admins::CoursesController < ApplicationController
  def index
    @course=Course.new
    @courses=Course.all
  end

  def edit
    @course=Course.find(params[:id])
  end

  def create
    @course=Course.new(course_params)
    @course.save
    redirect_to admins_courses_path
  end

  def update
    @course = Course.find(params[:id])
    @course.update(course_params)
    redirect_to admins_courses_path
  end


  private
  def course_params
    params.require(:course).permit(:name,:detail,:lesson_id)
  end
end
