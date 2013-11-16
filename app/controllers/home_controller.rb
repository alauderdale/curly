class HomeController < ApplicationController
  def index
    @users = User.all
    @shots = Shot.page(params[:page]).order('created_at DESC')
  end
end
