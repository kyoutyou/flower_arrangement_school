class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.integer:user_id, null: false
      t.string:name, null: false
      t.text:detail, null: false

      t.timestamps
    end
  end
end
