class AppMailer < ActionMailer::Base
	def send_coupon_email(email, coupon)
		@email = email
		@coupon = coupon
		mail to: @email, from: 'coupons@bbbuy.com', subject: "Your Coupon"
	end
end