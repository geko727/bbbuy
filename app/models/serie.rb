class Serie < ActiveRecord::Base
	has_many :coupons

	validates :name, presence: true
	validates :value, presence: true
end
