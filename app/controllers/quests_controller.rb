class QuestsController < ApplicationController
  def index
  	@quests = Quest.all
  	render json: @quests
  end
end
