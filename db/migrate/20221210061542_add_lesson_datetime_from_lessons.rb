class AddLessonDatetimeFromLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :lesson_datetime, :datetime
  end
end
