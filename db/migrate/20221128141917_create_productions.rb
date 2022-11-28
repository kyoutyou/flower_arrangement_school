class CreateProductions < ActiveRecord::Migration[6.1]
  def change
    create_table :productions do |t|

      t.timestamps
    end
  end
end
