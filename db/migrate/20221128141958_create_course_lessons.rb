class CreateCourseLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :course_lessons do |t|

      t.timestamps
    end
  end
end
