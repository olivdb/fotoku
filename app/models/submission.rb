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

	STATUSES = [STATUS_PENDING_REVIEW = 0, STATUS_REJECTED = 1, STATUS_ACCEPTED = 2, STATUS_ACCEPTED_WITH_EXTRA_CREDIT = 3]
    validates :status, inclusion: { in: STATUSES }

	def self_review_status
		if quest.self_reviewable?
			lat1 = quest.latitude * Math::PI / 180
			lat2 = latitude * Math::PI / 180
			d_lat = (latitude - quest.latitude) * Math::PI / 180
			d_lng = (longitude - quest.longitude) * Math::PI / 180

			s_lat = Math.sin(d_lat / 2)
			s_lng = Math.sin(d_lng / 2)
			a = s_lat * s_lat + s_lng * s_lng * Math.cos(lat1) * Math.cos(lat2)
			distance =  6371000 * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a)); 
			Rails.logger.debug("Submission location is #{distance}m away from quest location. The self-review threshold is #{quest.self_review_range}m.")

			if distance <= quest.self_review_range
				return Submission::STATUS_ACCEPTED
			end
		end
		return Submission::STATUS_PENDING_REVIEW
	end
end
