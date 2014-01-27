class QuestsController < ApplicationController
  #before_action :signed_in_user
  skip_before_filter :verify_authenticity_token # not sure it's ok, see http://stackoverflow.com/questions/20745843/is-this-rails-json-authentication-api-using-devise-secure
  ## code to test:
  #skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  def index
    #Rails.logger.debug("lat: #{params["latitude"]} lng: #{params["longitude"]}")
    mylon = params["longitude"].to_f
    mylat = params["latitude"].to_f
    max_dist_in_miles = 10.0
    lon1 = mylon - max_dist_in_miles / (Math.cos(mylat * Math::PI / 180.0) * 69.0).abs
    lon2 = mylon + max_dist_in_miles / (Math.cos(mylat * Math::PI / 180.0) * 69.0).abs
    lat1 = mylat - max_dist_in_miles / 69.0
    lat2 = mylat + max_dist_in_miles / 69.0


  	@quests = Quest.where(latitude: lat1..lat2, longitude: lon1..lon2)
  	#json = @quests.to_json include: { owner: { only: [:id, :name] } }, except: [:owner_id, :created_at, :updated_at]
  	#json = JSON.pretty_generate(JSON.parse(json)) #only for debug!
  	#render json: json
  	#respond_to do |format|
    #  format.html { render json: json }
    #  format.json { }
    #end
  end 

  def create
  	@quest = current_user.quests.build(quest_params)
  	if @quest.extra_credit_description.blank?
  		@quest.extra_credit_description = nil
  	end
    if @quest.save
      #render :json => { "quest_id" => @quest.id }, :status => :ok
    else
      Rails.logger.debug(@quest)
      render :json => { "error" => "Invalid quest data" }, :status => :bad_request
    end
  end

  def show
  	@quest = Quest.find(params[:id])
  end

  private

    def quest_params
      params.require(:quest).permit([:title, :photo, :extra_credit_description, :longitude, :latitude])
    end

end
