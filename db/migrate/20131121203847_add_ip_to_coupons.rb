class AddIpToCoupons < ActiveRecord::Migration
  def change
  	add_column :coupons, :ip, :string
  end
end
