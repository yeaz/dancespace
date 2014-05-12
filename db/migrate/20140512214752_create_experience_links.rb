class CreateExperienceLinks < ActiveRecord::Migration
  def change
    create_table :experience_links do |t|
      t.references :collab, polymorphic: true
      t.references :experience
      t.timestamps
    end
  end
end
