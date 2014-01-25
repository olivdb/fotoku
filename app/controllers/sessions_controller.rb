require 'open-uri'

class SessionsController < ApplicationController
	skip_before_filter :verify_authenticity_token	
	respond_to :json

	def create
		user_access_token = params[:fb_access_token]
		user_fb_id = params[:fb_id]
		fb_get_user_info_for_access_token_url_string = "https://graph.facebook.com/debug_token?input_token=#{user_access_token}&access_token=#{ENV['FB_APP_ACCESS_TOKEN']}"
		json_object = JSON.parse(open(URI.encode(fb_get_user_info_for_access_token_url_string)).read)
		if json_object["data"]["is_valid"] && json_object["data"]["app_id"] == ENV['FB_APP_ID'].to_i && json_object["data"]["user_id"] == params[:fb_id].to_i
			user = User.find_by(facebook_id: json_object["data"]["user_id"])
			if !user
				user = User.create(name: params[:fb_name], facebook_id: params[:fb_id])
			end
			sign_in(user)
			render :json => {"authentication_token" => self.current_user.authentication_token_plain}, :status => :ok
			return
		end
		render :json => {"error" => "There was an error while Loggin in (invalid Facebook access token)"}, :status => :bad_request
  	end

end
