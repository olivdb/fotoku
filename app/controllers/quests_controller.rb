class QuestsController < ApplicationController
  #before_action :signed_in_user
  skip_before_filter :verify_authenticity_token 

  def index
  	@quests = Quest.all
  	#output_json = JSON.pretty_generate(JSON.parse(@quests.to_json))
  	#output_json = JSON.pretty_generate(@quests.map(&:attributes))
  	json = @quests.to_json include: { owner: { only: [:id, :name] } }, except: [:owner_id, :created_at, :updated_at]
  	json = JSON.pretty_generate(JSON.parse(json)) #only for debug!

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
