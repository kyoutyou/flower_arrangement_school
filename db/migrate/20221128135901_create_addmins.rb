class CreateAddmins < ActiveRecord::Migration[6.1]
  def change
    create_table :addmins do |t|

      t.timestamps
    end
  end
end
