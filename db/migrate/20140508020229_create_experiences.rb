class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :content, default: "", null: false
      t.belongs_to :user
      t.timestamps
    end
  end
end
