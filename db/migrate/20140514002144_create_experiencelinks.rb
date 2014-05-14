class CreateExperiencelinks < ActiveRecord::Migration
  def change
    create_table :experiencelinks do |t|
      t.integer :user_id
      t.string :collab_type
      t.references :experience
      t.timestamps
    end
  end
end
