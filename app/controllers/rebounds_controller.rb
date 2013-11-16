class ReboundsController < ApplicationController

	def new
	    if current_user
	      @from_shot = Shot.find(params[:id])
	      @shot = Shot.new
	    else
	      redirect_to new_user_session_path
	    end
  	end

	def create
		@from_shot = Shot.find(params[:id])
	    @shot = Shot.new(params[:shot])
	    @shot.user_id = current_user.id
	    if @shot.save
	    #If save succeeds return to list action
	      Rebound.create(:from_shot_id => @from_shot.id, :to_shot_id => @shot.id)
	      redirect_to shots_path, :notice => "Rebound Created"
	    #if form fails, redisplay form so user can fix problems
	    else
	      flash[:alert]= "Make sure the file you uploaded is an audio clip under 30 seconds!"
	      render :action => :new

	    end
  	end

  	def show
	    @shot = Shot.find(params[:id])
	    @rebounds = @shot.shots.page(params[:page]).order('created_at DESC')
  	end
end
