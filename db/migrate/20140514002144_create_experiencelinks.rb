class CreateExperiencelinks < ActiveRecord::Migration
  def change
    create_table :experiencelinks do |t|
      t.references :collab, polymorphic: true
      t.references :experience
      t.timestamps
    end
  end
end
