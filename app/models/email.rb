class Email < ActiveRecord::Base
	has_many :coupons
end
