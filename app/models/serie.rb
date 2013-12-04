class Serie < ActiveRecord::Base
	has_many :coupons

	validates :name, presence: true
	validates_numericality_of :value, :greater_than => 0
	before_create :generate_token

  	def generate_token
  		self.token = SecureRandom.urlsafe_base64
  	end

	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv << column_names
	    all.each do |serie|
	      csv << serie.attributes.values_at(*column_names)
	    end
	  end
	end

	def change_method
		
		if self.active == true
			self.update_attributes(active: false)
		elsif self.active == false
			self.update_attributes(active: true)
		end
		
	end
end
