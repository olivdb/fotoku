class QuestsController < ApplicationController
  #before_action :signed_in_user
  skip_before_filter :verify_authenticity_token # not sure it's ok, see http://stackoverflow.com/questions/20745843/is-this-rails-json-authentication-api-using-devise-secure
  ## code to test:
  #skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  def index
  	@quests = Quest.all
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
      render :json => { "quest_id" => @quest.id }, :status => :ok
    else
      render :json => { "error" => "Invalid quest data" }, :status => :bad_request
    end
  end

  def show
  	@quest = Quest.find(params[:id])
  end

  private

    def quest_params
      params.require(:quest).permit([:title, :photo, :extra_credit_description])
    end

end
