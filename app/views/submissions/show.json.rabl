object @submission

attributes :id, :user_id, :quest_id, :status, :coins_earned, :extra_credit_coins_earned, :xp, :submitted_at

node :photo_url do |submission|
	submission.photo.url(:medium)
end


child :user => :user do
	attributes :id
end

child :quest => :quest do
	attributes :id
end