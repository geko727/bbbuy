class AppMailer < ActionMailer::Base
	def send_coupon_email(email, cupon, serie)
		@email = email
		@cup = cupon
		@serie = serie
		mail to: @email, from: 'coupons@bbbuy.com', subject: "Your Coupon"
	end
end