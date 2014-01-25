object @quest

attributes :id, :title

child :owner => :owner do
	attributes :id, :name
end

glue :photo do
	attributes :url => :photo_url
end