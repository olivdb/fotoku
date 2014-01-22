module SessionsHelper
	#attr_accessor authentication_token_plain
	#def sign_in(user)
		    #authentication_token = User.new_authentication_token
		    #cookies.permanent[:authentication_token] = authentication_token
		    #user.update_attribute(:authentication_token, User.encrypt(authentication_token))
	    #self.current_user = user
		    #self.authentication_token_plain = user.authentication_token_plain
		    ##authentication_token
  	#end

  	def signed_in?
    	!current_user.nil?
  	end

  	def current_user=(user)
    	@current_user = user
  	end

  	def find_current_user_with_authentication_token
  		authenticate_or_request_with_http_token { |token, options| authentication_token_plain = token }
		authentication_token = User.encrypt(authentication_token_plain)
		User.find_by(authentication_token: authentication_token)
  	end

	def current_user
		@current_user ||= find_current_user_with_authentication_token
	end
end
