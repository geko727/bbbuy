class AddIp2ToCoupons < ActiveRecord::Migration
  def change
  	add_column :coupons, :ip2, :string
  end
end
