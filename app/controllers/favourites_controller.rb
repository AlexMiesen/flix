class FavouritesController < ApplicationController
	before_action :require_signin
	before_action :set_movie

	def create
		@movie.favourites.create!(user: current_user)
		redirect_to @movie, notice: "Thanks for fav'ing!"
	end

	def destroy
		favourite = current_user.favourites.find(params[:id])
		favourite.destroy
		redirect_to @movie, notice: "Sorry you unfaved it!"
	end

	private

	def set_movie
		@movie = Movie.find(params[:movie_id])
	end 
end
