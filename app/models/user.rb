class User < ApplicationRecord
  has_secure_password

	has_many :reviews, dependent: :destroy
	has_many :favourites, dependent: :destroy
	has_many :favourite_movies, through: :favourites, source: :movie 

	scope :by_name, -> { order(:name) }
	scope :not_admins, -> { by_name.where(admin: false) }
	

	validates :name, presence: true

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

end