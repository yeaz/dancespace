class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :youtube_id, null: false
      t.references :user
      t.timestamps
    end
  end
end
