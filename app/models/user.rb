class User < ActiveRecord::Base
	has_many :quests, foreign_key: "owner_id", dependent: :destroy
	has_many :submissions
	before_create :generate_authentication_token
  	attr_accessor :authentication_token_plain

	def User.new_authentication_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def generate_authentication_token
		self.authentication_token_plain = User.new_authentication_token
		self.authentication_token = User.encrypt(self.authentication_token_plain)
	end



end
