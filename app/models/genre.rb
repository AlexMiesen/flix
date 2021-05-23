class Genre < ApplicationRecord
	has_many :charaterizations, dependent: :destroy
	has_many :movies, through: :charaterizations
	validates :name,  presence: true, uniqueness: true 
end
