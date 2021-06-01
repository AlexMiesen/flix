class GenresController < ApplicationController
	before_action :require_signin
	before_action :require_admin

	def index
		@genres = Genre.all
	end

	def new

	end

	def create

	end

	def edit
		@genre = Genre.find(params[:id])
	end

	def update
		@genre = Genre.find(params[:id])
		@genre.update(genre_params)
		redirect_to genres_path, notice: "Genre successfully updated!"
	end 
		
	def destroy

	end

	private

	def genre_params
		params.require(:genre).permit(:name)
	end
end
