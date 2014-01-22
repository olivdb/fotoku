require 'open-uri'

class SessionsController < ApplicationController
	skip_before_filter :verify_authenticity_token	

	def create
		APP_ACCESS_TOKEN = "584021338356865|sGZCpLdBeRJWkMrOhR_-iavW73c"
		APP_ID = 584021338356865
		user_access_token = params[:fb_access_token]
		user_fb_id = params[:fb_id]
		fb_get_user_info_for_access_token_url_string = "https://graph.facebook.com/debug_token?input_token=#{user_access_token}&access_token=#{APP_ACCESS_TOKEN}"
		json_object = JSON.parse(open(URI.encode(fb_get_user_info_for_access_token_url_string)).read)
		if json_obj["data"]["is_valid"] && json_obj["data"]["app_id"] == 584021338356865 && json_obj["data"]["user_id"] == params[:fb_id]
			user = User.find_by(facebook_id: json_obj["data"]["user_id"])
			if !user
				user = User.create(name: params[:fb_name], facebook_id: params[:fb_id])
			end
			#sign_in(user)
			self.current_user = user
			#respond with success, authentication_token
			render :json { "success" => true, "authentication_token" => user.authentication_token_plain }
		else
			#respond with error
			render :json { "success" => false, "error" => {"login error"} }
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
