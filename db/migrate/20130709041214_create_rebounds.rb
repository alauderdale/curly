class CreateRebounds < ActiveRecord::Migration
  def change
    create_table :rebounds do |t|
      t.integer :from_shot_id
      t.integer :to_shot_id
      t.timestamps
    end
  end
end
