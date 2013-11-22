class AppMailer < ActionMailer::Base
	def send_coupon_email(email, coupon, ip, ip2, full_name)
		@email = email
		@coupon = coupon
		@ip = ip
		@ip2 = ip2
		@full_name = full_name
		mail to: @email, from: 'coupons@bbbuy.com', subject: "Your Coupon"
	end
end