class CreateVideochats < ActiveRecord::Migration
  def change
    create_table :videochats do |t|
      t.string :title, null: false
      t.string :host_peer_id
      t.belongs_to :user
      t.timestamps
    end
  end
end
