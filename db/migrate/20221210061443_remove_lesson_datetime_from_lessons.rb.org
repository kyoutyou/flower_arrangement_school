class RemoveLessonDatetimeFromLessons < ActiveRecord::Migration[6.1]
  def change
    remove_column :lessons, :lesson_datetime, :datetime
  end
end
