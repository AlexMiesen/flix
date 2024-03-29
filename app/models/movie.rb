class Movie < ApplicationRecord
	before_validation :generate_slug
	to_param :title

	RATINGS = %w(G PG PG-13 R NC-17)
	
	has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy #the most-recent review appeared first in the listing by having the lambda 
	has_many :critics, through: :reviews, source: :user
	has_many :favourites, dependent: :destroy
	has_many :fans, through: :favourites, source: :user
	has_many :characterizations, dependent: :destroy
	has_many :genres, through: :characterizations

	validates :title, presence: true, uniqueness: true

	validates :released_on, :duration, presence: true

	validates :slug, uniqueness: true

	validates :description, length: { minimum: 25 }

	validates :total_gross, numericality: { greater_than_or_equal_to: 0 }

	validates :image_file_name, allow_blank: true, format: {
		with:    /\w+\.(gif|jpg|png)\z/i,
		message: "must reference a GIF, JPG, or PNG image"
	}

	validates :rating, inclusion: { in: RATINGS }

	scope :released, -> { where("released_on <= ?", Time.now).order(released_on: :desc) }
	scope :hits, -> { released.where('total_gross >= 300000000').order(total_gross: :desc) }
	scope :flops, -> { released.where('total_gross < 50000000').order(total_gross: :asc) }
	scope :upcoming, -> { where("released_on > ?", Time.now).order(released_on: :asc) }
	scope :rated, -> (rating) { released.where(rating: rating) }
	scope :recent, -> (max=5){ released.limit(max)}
	scope :grossed_less_than, -> (amount) { released.where('total_gross < ?', amount) }
	scope :grossed_greater_than, -> (amount) {released.where('total_gross > ?', amount) }

  def self.recently_added
    order('created_at desc').limit(3)
  end

  def flop?
    total_gross.blank? || total_gross < 50000000
  end

	def average_stars
		reviews.average(:stars)
	end

	def recent_reviews
		# reviews.where("created_at < ?", Time.now).order(created_at: :desc).limit(2)
		reviews.order('created_at desc').limit(2)
	end

	def generate_slug
		self.slug ||= title.parameterize if title
	end

	def to_param
		slug
	end 
end
