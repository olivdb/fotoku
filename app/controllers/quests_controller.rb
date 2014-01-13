class QuestsController < ApplicationController
  def index
  	@quests = Quest.all
  	#output_json = JSON.pretty_generate(JSON.parse(@quests.to_json))
  	#output_json = JSON.pretty_generate(@quests.map(&:attributes))
  	json = @quests.to_json include: { owner: { only: [:id, :name] } }
  	json = JSON.pretty_generate(JSON.parse(json)) #only for debug!
  	render json: json
  end
end
