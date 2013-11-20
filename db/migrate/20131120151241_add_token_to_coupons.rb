class AddTokenToCoupons < ActiveRecord::Migration
  def change
  	add_column :coupons, :token, :string
  	Coupon.all.each do |coupon|
  		coupon.token = SecureRandom.urlsafe_base64
  		coupon.save
  	end
  end
end
