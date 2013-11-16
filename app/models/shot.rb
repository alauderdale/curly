class Shot < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :rebounds, :class_name => "Rebound", :foreign_key => "from_shot_id", :dependent => :destroy
  has_many :reverse_rebounds, :class_name => "Rebound",
      :foreign_key => "to_shot_id", :dependent => :destroy
  has_many :shots, :through => :rebounds, :source => :to_shot
  has_attached_file :shot_image, :styles => { :medium => "88x88#", :thumb => "16x16#" }, :default_url => "/images/:style/missing_avatar.png"
  acts_as_taggable
  acts_as_votable
  self.per_page = 12
end