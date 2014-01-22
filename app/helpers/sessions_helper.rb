module SessionsHelper
	def sign_in(user)
	    authentication_token = User.new_authentication_token
	    cookies.permanent[:authentication_token] = authentication_token
	    user.update_attribute(:authentication_token, User.encrypt(authentication_token))
	    self.current_user = user
  	end

  	def signed_in?
    	!current_user.nil?
  	end

  	def current_user=(user)
    	@current_user = user
  	end

	def current_user
		authentication_token = User.encrypt(cookies[:authentication_token])
		@current_user ||= User.find_by(authentication_token: authentication_token)
	end
end
