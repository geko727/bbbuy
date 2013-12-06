class Coupon < ActiveRecord::Base
  belongs_to :serie
  belongs_to :email
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


end
