class AddCommentsTable < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.integer :user_id
      t.integer :shot_id
      t.timestamps
    end
  end
end
