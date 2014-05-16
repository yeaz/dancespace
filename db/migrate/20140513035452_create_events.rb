class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text   :description, null: false
      t.belongs_to :studio
      t.timestamps
    end
  end
end
