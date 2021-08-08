class User < ApplicationRecord
  has_secure_password
	before_validation :generate_slug
	before_save :format_username

	has_many :reviews, dependent: :destroy
	has_many :favourites, dependent: :destroy
	has_many :favourite_movies, through: :favourites, source: :movie 

	scope :by_name, -> { order(:name) }
	scope :not_admins, -> { by_name.where(admin: false) }
	

	validates :name, presence: true

	validates :slug, uniqueness: true

	validates :email, presence: true, format: /\A\S+@\S+\z/, uniqueness: { case_sensitive: false }

	validates :password, length: { minimum: 10, allow_blank: true }

	validates :username, presence: false, format: /\A[A-Z0-9]+\z/i, uniqueness: { case_sensitive: false}
	
	def gravatar_id
		Digest::MD5::hexdigest(email.downcase)
	end

	def self.authenticate(email, password)
		user = User.find_by(email: email)
		user && user.authenticate(password)
	end 

	def format_username
		self.username = username.downcase
	end

	def format_email
		self.email = email.downcase
	end

	def generate_slug
		self.slug ||= name.parameterize if name
	end

	def to_param
		slug
	end 

end