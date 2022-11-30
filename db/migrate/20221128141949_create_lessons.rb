class CreateLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :lessons do |t|
      t.integer:course_lesson_id, null: false
      t.datetime:lesson_datetime, null:false

      t.timestamps
    end
  end
end
