class AppMailer < ActionMailer::Base
	def send_coupon_email(email, coupon, ip)
		@email = email
		@coupon = coupon
		@ip = ip
		mail to: @email, from: 'coupons@bbbuy.com', subject: "Your Coupon"
	end
end