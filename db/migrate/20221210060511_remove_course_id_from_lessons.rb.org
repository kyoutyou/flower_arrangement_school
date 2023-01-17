class RemoveCourseIdFromLessons < ActiveRecord::Migration[6.1]
  def change
    remove_column :lessons, :course_id, :integer
  end
end
