module SessionsHelper
	#attr_accessor authentication_token_plain
	def sign_in(user)
		    #authentication_token = User.new_authentication_token
		    #cookies.permanent[:authentication_token] = authentication_token
		    #user.update_attribute(:authentication_token, User.encrypt(authentication_token))
		user.generate_authentication_token
		user.save
	    self.current_user = user
		    #self.authentication_token_plain = user.authentication_token_plain
		    ##authentication_token
  	end

  	def signed_in?
    	!current_user.nil?
  	end

  	def current_user=(user)
    	@current_user = user
  	end

  	def find_current_user_with_authentication_token
  		authentication_token_plain = request.headers['HTTP_AUTH_TOKEN']
  		Rails.logger.debug("au_to_pl: #{authentication_token_plain} -> #{User.encrypt(authentication_token_plain)} -> #{User.all.count}")
		authentication_token = User.encrypt(authentication_token_plain)
		User.find_by(authentication_token: authentication_token)
  	end

	def current_user
		@current_user ||= find_current_user_with_authentication_token
	end

end
