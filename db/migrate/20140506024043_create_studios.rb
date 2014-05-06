class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.timestamps
    end
  end
end
