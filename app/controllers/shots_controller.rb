class ShotsController < ApplicationController

  def index
    if current_user
      if params[:tag]
        @shots = Shot.tagged_with(params[:tag]).page(params[:page]).order('created_at DESC')
        @tag = params[:tag]
      else
        @shots = Shot.order().page(params[:page]).order('created_at DESC')
        #following and current user shots
        # @shots = Shot.where(:user_id=>[*current_user.followed_users, current_user.id]).page(params[:page]).order('created_at DESC')
      end
    else
      redirect_to root_path, :alert => "Create an account to view this section"
    end
  end

  def show
    @shot = Shot.find(params[:id])
    @comment = Comment.new( :shot => @shot )
  end

  def new
    if current_user
      @shot = Shot.new
    else
      redirect_to new_user_session_path

    end
  end

  def create
    @shot = Shot.new(params[:shot])
    @shot.user_id = current_user.id
    if @shot.save
    #If save succeeds return to list action
      redirect_to shots_path, :notice => "Tip Created"
    #if form fails, redisplay form so user can fix problems
    else
      flash[:alert]= "Opps!"
      render :action => :new

    end
  end

  def edit
    @shot = Shot.find(params[:id])
    if current_user && current_user.id == @shot.user_id

    else
      redirect_to new_user_session_path
    end
  end

  def likes
    @title = "Fans"
    @shot = Shot.find(params[:id])
  end

  def following
    if current_user
    #following and current user shots
      @shots = Shot.where(:user_id=>[*current_user.followed_users, current_user.id]).page(params[:page]).order('created_at DESC')
    else
      redirect_to root_path, :alert => "Create an account to view this section"
    end
  end

  def update_shot
    # Find object using form parameters
    @shot = Shot.find(params[:id])
    # Update the object
    if @shot.update_attributes(params[:shot])
      # If update succeeds, redirect to the list action
      redirect_to shot_path, :notice => "Tip Updated"
    else
      # If save fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def delete
    @shot = Shot.find(params[:id])
  end

  def destroy_shot
    shot = Shot.find(params[:id])
    shot.destroy
    redirect_to shots_path, :notice => "Shot Deleted"
  end

  def like_shot
    shot = Shot.find(params[:id])
    user = current_user
    shot.liked_by user
    redirect_to shot_path
  end

  def un_like_shot
    shot = Shot.find(params[:id])
    user = current_user
    shot.disliked_by user
    redirect_to shot_path
  end
end
