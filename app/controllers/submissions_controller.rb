class SubmissionsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	def create
		@submission = current_user.submissions.find_by(quest_id: params[:quest_id])
		if @submission
			#Rails.logger.debug("found existing submission #{@submission.to_json}")
			@submission.assign_attributes(submission_params)
			#Rails.logger.debug("found existing submission : after params assigned -> #{@submission.to_json}")
		else
			#Rails.logger.debug("will create a new submission for #{@submission.to_json}")
			@submission = current_user.submissions.build(submission_params)
			#Rails.logger.debug("created: #{@submission.to_json}")
		end

		@submission.status = @submission.self_review_status
		Rails.logger.debug(" after review! => #{@submission.to_json}")

		if !@submission.save
	      Rails.logger.debug("Invalid submission received: #{@submission.to_json}")
	      render :json => { "error" => "Invalid submission data" }, :status => :bad_request
    	end
	end

	#just for test
	def show 
  		@submission = Submission.find(params[:id])
  	end

	def submission_params
      params.require(:submission).permit(:photo, :quest_id, :has_extra_credit, :longitude, :latitude)
    end
end
