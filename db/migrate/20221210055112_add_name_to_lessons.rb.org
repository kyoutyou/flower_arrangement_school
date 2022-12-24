class AddNameToLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :name, :string
  end
end
