class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :member
      t.belongs_to :studio
      t.boolean    :is_admin
      t.timestamps
    end
  end
end
