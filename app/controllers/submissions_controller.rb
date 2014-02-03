class SubmissionsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	def create
		@submission = current_user.submissions.build(submission_params)
		if !@submission.save
	      Rails.logger.debug("Invalid submission received: #{@submission}")
	      render :json => { "error" => "Invalid submission data" }, :status => :bad_request
    	end
	end

	def show
  		@submission = Submission.find(params[:id])
  	end

	def submission_params
      params.require(:submission).permit(:photo, :quest_id, :has_extra_credit, :longitude, :latitude)
    end
end
