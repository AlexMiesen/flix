module ReviewsHelper

	def format_average_stars(movie)
		if movie.average_stars.nil?
			content_tag(:strong, "No reviews")
		else
			"*" * movie.average_stars.to_i
			# pluralize(number_with_precision(movie.average_stars, precision: 1), 'stars')
		end
	end

end