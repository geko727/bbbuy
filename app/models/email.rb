class Email < ActiveRecord::Base
	has_many :coupons

	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv << column_names
	    all.each do |serie|
	      csv << serie.attributes.values_at(*column_names)
	    end
	  end
	end
end
