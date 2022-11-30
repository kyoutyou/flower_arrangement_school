class CreateProductions < ActiveRecord::Migration[6.1]
  def change
    create_table :productions do |t|
      t.integer:user_id, null: false
      t.string:production_name, null: false
      t.text:introduction, null: false

      t.timestamps
    end
  end
end
