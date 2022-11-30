class CreateCourseLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :course_lessons do |t|
      t.integer:lesson_id, null: false
      t.integer:course_id, null: false

      t.timestamps
    end
  end
end
