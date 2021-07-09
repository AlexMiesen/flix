class Review < ApplicationRecord
  STARS = 1..5
	
	belongs_to :movie
	belongs_to :user

	scope :past_n_days, ->(days) { where("created_at >= ?", days.days.ago)}


	validates :comment, length: { minimum: 4}

	validates :stars, inclusion: { in: STARS, message: "must be between 1 and 5" }
end
