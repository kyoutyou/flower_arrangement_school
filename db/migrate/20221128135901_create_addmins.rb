class CreateAddmins < ActiveRecord::Migration[6.1]
  def change
    create_table :addmins do |t|
      t.string:email, null: false
      t.string:encrypted_password, null: false

      t.timestamps
    end
  end
end
