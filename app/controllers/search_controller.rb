class SearchController < ApplicationController
	def index
		require 'will_paginate/array'
		@users = User.basic_search(params[:search])
		@search = params[:search]
		# @shots = shots.page(params[:page]).order('created_at DESC').all
		# shots = Shot.basic_search(params[:search]) + Shot.tagged_with(params[:search])
		# @shots = shots.paginate page: params[:page], per_page: 12
		shots = Shot.basic_search(params[:search])+Shot.tagged_with(params[:search])
		@shots = shots.paginate page: params[:page], per_page: 12

	end
end
