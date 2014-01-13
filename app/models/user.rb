class User < ActiveRecord::Base
	has_many :quests, foreign_key: "owner_id", dependent: :destroy
end
