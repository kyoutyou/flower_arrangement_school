class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.integer:admin_id, null: false
      t.integer:user_id, null: false
      t.string:course_name, null: false
      t.text:course_detail, null: false

      t.timestamps
    end
  end
end
