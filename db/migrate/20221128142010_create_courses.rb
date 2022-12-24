class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.text :detail, null: false
      # t.integer :lesson_id, null: false
      t.integer :number, null: false

      t.timestamps
    end
  end
end
