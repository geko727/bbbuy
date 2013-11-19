class Serie < ActiveRecord::Base
	has_many :coupons

	validates :name, presence: true
	validates :value, presence: true

	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv << column_names
	    all.each do |serie|
	      csv << serie.attributes.values_at(*column_names)
	    end
	  end
	end
end
