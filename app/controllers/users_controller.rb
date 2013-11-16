class UsersController < ApplicationController

  # before_filter :authenticate_user!, 
  #       only: [ :following, :followers]
  def index
    # authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.order().page(params[:page]).order('created_at DESC')

  end

  def show
    @user = User.find(params[:id])
    @user_shots = @user.shots.page(params[:page]).order('created_at DESC')
    @likes = @user.get_up_voted Shot.page(params[:page]).order('created_at DESC')

  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def likes
    @title = "Likes"
    @user = User.find(params[:id])
    @likes = @user.get_up_voted Shot.page(params[:page]).order('created_at DESC')
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_following'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_followers'
  end
end