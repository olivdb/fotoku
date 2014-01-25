class Quest < ActiveRecord::Base
	belongs_to :owner, class_name: "User" 
	validate :title, presence: true
	#validate :photo_url, presence: true
	validate :owner_id, presence: true
	has_attached_file :photo, styles: {
		thumb: '100x100>',
		square: '200x200#',
		medium: '300x300>'
	}
end
