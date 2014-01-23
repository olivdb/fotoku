class QuestsController < ApplicationController
  #before_action :signed_in_user
  skip_before_filter :verify_authenticity_token # not sure it's ok, see http://stackoverflow.com/questions/20745843/is-this-rails-json-authentication-api-using-devise-secure
  ## code to test:
  #skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  #respond_to :json

  def index
  	@quests = Quest.all
  	#output_json = JSON.pretty_generate(JSON.parse(@quests.to_json))
  	#output_json = JSON.pretty_generate(@quests.map(&:attributes))
  	json = @quests.to_json include: { owner: { only: [:id, :name] } }, except: [:owner_id, :created_at, :updated_at]
  	json = JSON.pretty_generate(JSON.parse(json)) #only for debug!

  	#authenticate_or_request_with_http_token { |token, options| authentication_token_plain = token }

  	#Rails.logger.debug("request made by #{request.headers['HTTP_AUTH_TOKEN']} ou alors #{request.headers['HTTP_AUTHORIZATION']} !!")
  	#Rails.logger.debug("curr = #{current_user.name}")
  	render json: json
  end 

  def create
  	@quest = User.find(1).quests.build(quest_params)
    #@quest = current_user.quests.build(quest_params)
    if @quest.save
      render json: {}
    else
      render json: {}
    end
  end

  private

    def quest_params
      Rails.logger.debug("Received params: #{params.to_yaml}")
      params.require(:quest).permit([:title, :photo_url])
    end

end
