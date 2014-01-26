class Quest < ActiveRecord::Base
	belongs_to :owner, class_name: "User" 
	has_attached_file :photo, styles: {
		thumb: '43x43>',
		#square: '200x200#',
		medium: '320x320>'
	}, :default_url => ""#/images/:style/missing.png"

	validate :title, presence: true
	validate :owner_id, presence: true
	validates_attachment :photo, :presence => true, 
	:content_type => { :content_type => "image/jpg" }, 
	:size => { :in => 0..1.megabyte },
	:dimensions => { :width => 640, :height => 640 }
	#validates :photo, :dimensions => { :width => 300, :height => 300 }
	
end
