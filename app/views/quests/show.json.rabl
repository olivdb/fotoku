object @quest

attributes :id, :title, :latitude, :longitude

child :owner => :owner do
	attributes :id, :name
end

glue :photo do
	attributes :url => :photo_url
end

node :photo_url_medium do |quest|
	quest.photo.url(:medium)
end

node :photo_url_thumb do |quest|
	quest.photo.url(:thumb)
end