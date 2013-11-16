class AddAvatarColumnsToUsers < ActiveRecord::Migration
  def change
    add_attachment :users, :avatar
    add_attachment :shots, :shot_image
  end
end
