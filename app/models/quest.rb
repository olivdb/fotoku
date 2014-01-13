class Quest < ActiveRecord::Base
	belongs_to :owner, class_name: "User" 
	validate :title, presence: true
	validate :photo_url, presence: true
	validate :owner_id, presence: true
end
