class Submission < ActiveRecord::Base
	belongs_to :quest
	belongs_to :user
	has_attached_file :photo, styles: {
		medium: '320x320>'
	}, :default_url => ""#/images/:style/missing.png"

	validate :user_id, presence: true
	validate :quest_id, presence: true
	validates_attachment :photo, :presence => true, 
	:content_type => { :content_type => "image/jpg" }, 
	:size => { :in => 0..1.megabyte },
	:dimensions => { :width => 640, :height => 640 }
end
