class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer:user_id, null: false
      t.integer:lesson_id, null: false

      t.timestamps
    end
  end
end
