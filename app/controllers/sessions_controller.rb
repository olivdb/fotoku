require 'open-uri'

class SessionsController < ApplicationController
	skip_before_filter :verify_authenticity_token	

	def create
		APP_ACCESS_TOKEN = "584021338356865|sGZCpLdBeRJWkMrOhR_-iavW73c"
		user_access_token = params[:fb_access_token]
		fb_get_user_info_for_access_token_url_string = "https://graph.facebook.com/debug_token?input_token=#{user_access_token}&access_token=#{APP_ACCESS_TOKEN}"
		json_object = JSON.parse(open(URI.encode(fb_get_user_info_for_access_token_url_string)).read)
		if json_obj["data"]["is_valid"]
			user = User.find_by(facebook_id: json_obj["data"]["user_id"])
			if !user
				#create user
			end
			#respond with success
		else
			#respond with error
		end
		
		#Rails.logger.debug("Received params: app: #{app_name}, uid: #{user_fb_id}")

		#facebook_id
	    #user = User.find_by(email: params[:session][:email].downcase)
	    #if user && user.authenticate(params[:session][:password])
	    #  # Sign the user in and redirect to the user's show page.
	    #else
	    #  flash.now[:error] = 'Invalid email/password combination'
	    #  render 'new'
	    #end
  	end

end
