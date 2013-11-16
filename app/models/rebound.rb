class Rebound < ActiveRecord::Base
  belongs_to :to_shot, :class_name => "Shot"
  belongs_to :from_shot, :class_name => "Shot"
end